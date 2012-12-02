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
      content = File.read(LOGFILE)
      count = Hash.new(0)
      content.split(//).each { |c|
        count[c] += 1
      }
      say count
    end
  end

end
