module Vimentor
  class MetaInfo
    attr_reader :start_time

    def initialize()
      @start_time = Time.new()
    end

    def set_end_time()
      @end_time = Time.new()
    end

    def store(filename)
      marshal_dump = Marshal.dump(self)
      f = File.new(filename, "w")
      f.write(marshal_dump)
      f.close
    end

    def self.load(filename)
      f = File.open(filename, "r")
      obj = Marshal.load(f.read)
      f.close
      return obj
    end

  end
end
