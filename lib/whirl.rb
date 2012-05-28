$:.unshift File.expand_path("..", __FILE__) unless $:.include? File.expand_path("..", __FILE__)

require 'rake'
require 'thor'
require 'httparty'
require 'redis'
require 'json'

require 'whirl/version'
require 'whirl/redis'
require 'whirl/job/base'

module Whirl

  def self.jobs
    jobs = Whirl::Job.constants.
      map { |d| Whirl::Job.const_get(d) }.
      select { |d| d.respond_to? :perform }

    jobs -= [Whirl::Job::Base]
  end

  def self.run
    trap("SIGINT") do
      Whirl::Job::Base.newline
      Whirl::Job::Base.say "Whirled.", :green
      Whirl::Job::Base.newline
      exit 0
    end

    begin
      jobs.each do |j|
        fork do
          j.perform
        end
      end

      sleep whirl_interval
    end while loop?
  end

  def self.loop?
    true
  end

  def self.whirl_interval
    ENV['WHIRL_LOOP_INTERVAL'] || 10
  end

end
