module Vimentor

  LOGFILE = "/tmp/vimentor_keylog"

  class CLI < Thor
    desc "vim ARGS", "launch Vim session"
    def vim(*args)
      vimcmd = "vim -W #{LOGFILE} #{args.join(" ")}"
      say "Invoking: #{vimcmd}"
      system(vimcmd)
      say "End vim session."

      # Parse keylog
      log = Keylog.new(File.read(LOGFILE))
      say log.to_a.frequency
    end
  end

end
