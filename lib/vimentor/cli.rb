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
      d = SAVEROOT + Time.new().strftime("/%Y/%m/%d")
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

  end

end
