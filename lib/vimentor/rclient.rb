module Vimentor
  class Rclient

    def initialize()
      @connection = Rserve::Connection.new
    end

    def version()
      rdo("R.version.string").as_string
    end

    private
    def rdo(str)
      @connection.eval(str)
    end

  end
end
