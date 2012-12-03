module Vimentor

  LOGFILE = "/tmp/vimentor_keylog"
  SAVEROOT = Dir.home + "/vimentor";

  class CLI < Thor
    desc "vim ARGS", "launch Vim session"
    def vim(*args)
      info = MetaInfo.new()

      vimcmd = "vim -W #{LOGFILE} #{args.join(" ")}"
      say "Invoking: #{vimcmd}"
      system(vimcmd)
      say "End vim session."

      info.set_end_time()

      # Parse keylog
      log = Keylog.new(File.read(LOGFILE))
      say log.to_a.frequency

      # Create directory
      d = SAVEROOT + Time.new().strftime("/%Y/%m/%d")
      FileUtils.mkdir_p(d) unless File.directory?(d)

      # File name root
      unix_t = info.start_time.to_i.to_s
      fn_r = d + "/" + unix_t

      # Save keylog
      FileUtils.mv(LOGFILE, fn_r + ".keylog")

      # Save meta info
      info.store(fn_r + ".meta")

    end

  end

end
