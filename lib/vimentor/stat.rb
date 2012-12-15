module Vimentor
  class Stat
    def initialize(date)
      @date = date
    end

    def invoke_count()
      meta_files().size
    end

    def key_count()
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

