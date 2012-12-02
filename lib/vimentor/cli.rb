module Vimentor

  class CLI
    def self.start
      vimcmd = "vim -w ~/vimkeylog"
      puts "Invoking vim with -w option."
      system(vimcmd)
      puts "End vim session."
    end
  end

end
