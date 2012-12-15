module Vimentor
  class Stat
    def initialize(date)
      @date = date
    end

    def invoke_count()
    end

    def key_count()
    end

    def self.get_directory(date = Date.today)
      SAVEROOT + date.strftime("/%Y/%m/%d")
    end

  end
end

