module Vimentor
  class Stat
    def initialize(date)
      @date = date
    end

    def invoke_count()
      meta_files().size
    end

    def key_count_hash()
      count = Hash.new()
      for f in keylog_files()
        l = Keylog.new(
          File.read(
            Vimentor::Stat.get_directory(@date) + "/" + f))
        count.merge!(l.to_a.frequency) { |key, oldval, newval|
          oldval + newval
        }
      end
      return count
    end

    def total_key_count()
      count = 0
      key_count_hash().each do |k, v|
        count += v
      end
      return count
    end

    def self.get_directory(date = Date.today)
      SAVEROOT + date.strftime("/%Y/%m/%d")
    end

    private
    def meta_files()
      Dir.entries(Vimentor::Stat.get_directory(@date)).
        select { |f| f =~ /.*\.meta/ }
    end

    def keylog_files()
      Dir.entries(Vimentor::Stat.get_directory(@date)).
        select { |f| f =~ /.*\.keylog/ }
    end

  end
end

