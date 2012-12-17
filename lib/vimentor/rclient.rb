module Vimentor
  class Rclient
    def initialize()
      @connection = Rserve::Connection.new
    end

    def version()
      @connection.eval("R.version.string").as_string
    end
  end
end
