module Whirl

  module Job

    class Base

      class << self
        attr_accessor :job_action
      end

      def self.action(&block)
        self.job_action = block
      end

      def self.perform
        say "starting...", :blue
        begin
          job_action.call
        rescue Exception => e
          say "Job #{self.name} failed!", :red
          say ".. Reason: #{e.message}", :red
          if ENV['DEBUG']
            say ".. Backtrace:"
            puts e.backtrace
          end
        ensure
        end
      end

      def self.newline
        puts "\n"
      end

      def self.say(*args)
        args.push :cyan if args.size == 1
        @shell ||= Thor::Shell::Color.new
        message = "#{self.name.ljust(28, " ")} === #{args.shift}"
        @shell.say *[message, *args]
      end

      def self.redis_key(val)
        "#{self.name}:#{val}"
      end

      def self.redis
        @redis ||= Whirl::Redis.new
      end

    end

  end

end
