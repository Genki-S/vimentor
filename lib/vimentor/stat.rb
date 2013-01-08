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

    def sequential_mining(rclient)
      tmpf = Tempfile.new("sequence")
      event_id = 0
      for f in keylog_files()
        event_id += 1
        event_time = 0
        log = Keylog.new(File.read(get_dir() + "/" + f))
        for key in log.to_a
          event_time += 1
          line = event_id.to_s + " " + event_time.to_s + " " +
            "1" + " " + key
          tmpf.puts(line)
        end
      end
      tmpf.rewind
      cmd = <<END
x <- read_baskets(con = "#{tmpf.path}", info = c("sequenceID","eventID","SIZE"));
s1 <- cspade(x, parameter = list(support = 0.4), control = list(verbose = TRUE));
summary(s1)
as(s1, "data.frame")
END
      t = rclient.rdo(cmd)
      #puts t.as_list[0].levels
      puts t.as_list[0].as_strings
      tmpf.close
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

