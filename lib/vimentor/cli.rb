module Vimentor

	class CLI
		def start
			vimcmd = "vim -w ~/vimkeylog"
			system(vimcmd)
		end
	end

end

