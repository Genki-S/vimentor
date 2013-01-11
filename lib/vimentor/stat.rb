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
        l = Keylog.new(File.read(get_dir() + "/" + f))
        count.merge!(l.to_a.frequency) { |key, oldval, newval|
          oldval + newval
        }
      end
      return count
    end

    def most_frequent_keys(*args)
      if args.size > 2
        # TODO: raise exception
      elsif args.size == 0 # All
        key_count_hash.sort_by{|k, v| v}.reverse
      elsif args.size == 1 # Specified Number
        key_count_hash.sort_by{|k, v| v}.reverse[0..args[0]-1]
      elsif args.size == 2 # From ~ To
        key_count_hash.sort_by{|k, v| v}.reverse[args[0]..args[1]]
      end
    end

    def total_key_count()
      count = 0
      key_count_hash().each do |k, v|
        count += v
      end
      return count
    end

    def most_frequent_patterns()
      cnth = Hash.new(0)
      for len in 2..5
        for f in keylog_files()
          log_a = Keylog.new(File.read(get_dir() + "/" + f)).to_a
          for i in 0..log_a.length - len
            seqence = ""
            for j in i..i+len-1
              seqence += log_a[j]
            end
            cnth[seqence] += 1
          end
        end
      end
      return cnth
    end

    def self.get_directory(date = Date.today)
      SAVEROOT + date.strftime("/%Y/%m/%d")
    end

    private
    def get_dir()
      Vimentor::Stat.get_directory(@date)
    end

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

