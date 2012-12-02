module Vimentor

  class CLI < Thor
    desc "vim ARGS", "launch Vim session"
    def vim(*args)
      vimcmd = "vim -W ~/vimkeylog #{args.join(" ")}"
      say "Invoking: #{vimcmd}"
      system(vimcmd)
      say "End vim session."
    end
  end

end
