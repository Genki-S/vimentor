module Vimentor

  SAVEROOT = Dir.home + "/vimentor"

  class CLI < Thor
    desc "vim ARGS", "launch Vim session"
    def vim(*args)
      info = MetaInfo.new()
      logfile = Tempfile.new("vimkeylog")

      vimcmd = "vim -W #{logfile.path} #{args.join(" ")}"
      say "Invoking: #{vimcmd}"
      system(vimcmd)
      say "End vim session."

      info.set_end_time()

      # Parse keylog
      log = Keylog.new(logfile.read)
      say log.to_a.frequency

      # Create directory
      d = Vimentor::Stat.get_directory()
      FileUtils.mkdir_p(d) unless File.directory?(d)

      # File name root
      unix_t = info.start_time.to_i.to_s
      fn_r = d + "/" + unix_t

      # Save keylog
      FileUtils.cp(logfile.path, fn_r + ".keylog")
      logfile.close

      # Save meta info
      info.store(fn_r + ".meta")
    end

    desc "stat [DAY]", "show the stat of a day"
    def stat(date_str = Date.today.to_s)
      d = Date.parse(date_str)
      s = Stat.new(d)
      say "Stat of #{d.strftime("%Y/%m/%d (%a)")}"
      say "Invoke: #{s.invoke_count} times"
      say "Total key count: #{s.total_key_count}"
      cnth = s.most_frequent_patterns()
      puts "Top 10 frequent sequences"
      puts "Count\tSequence"
      freq_seqs = cnth.sort_by{|seq, cnt| cnt * -1}
      for i in 0..9
        puts "#{freq_seqs[i][1]}\t#{freq_seqs[i][0]}"
      end
    end

    desc "stat_a", "show the stat of all time"
    def stat_a()
      
    end

  end

end
