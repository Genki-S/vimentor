module Vimentor
  class Rclient

    def initialize()
      @connection = Rserve::Connection.new
      r_init()
    end

    def r_init()
      @connection.eval("library(Matrix)")
      @connection.eval("library(arules)")
      @connection.eval("library(arulesSequences)")
    end

    def version()
      rdo("R.version.string").as_string
    end

    def plot_2d_array(arr)
      n = []
      y = []
      arr.each do |a|
        n.push(a[0])
        y.push(a[1])
      end
      nstr = n.to_s.sub(/^\[/, "").sub(/\]$/, "")
      ystr = y.to_s.sub(/^\[/, "").sub(/\]$/, "")
      cmd = <<END
counts <- c(#{ystr});
names(counts) <- c(#{nstr});
barplot(counts);
END
      rdo(cmd)
      STDIN.gets
    end

    def rdo(str)
      @connection.eval(str)
    end

  end
end
