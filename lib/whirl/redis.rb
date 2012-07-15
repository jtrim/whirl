require 'forwardable'

module Whirl

  class Redis
    extend Forwardable

    def_delegators :@client, :get, :set

    attr_accessor :client

    def initialize
      self.client = if redis_url = ENV['REDISTOGO_URL']
        u = URI.parse(redis_url)
        ::Redis.new host: u.host, port: u.port, password: u.password
      else
        ::Redis.new
      end
    end

  end

end
