module Vimentor

  class CLI < Thor
    desc "vim", "launch Vim session"
    def vim()
      vimcmd = "vim -W ~/vimkeylog"
      puts "Invoking vim with -W option."
      system(vimcmd)
      puts "End vim session."
    end
  end

end
