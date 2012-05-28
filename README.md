# Whirl

A watered-down gem for looping over jobs. Pre-wired with Redis and HTTParty. Built with Heroku usage in mind.

## Installation

Add this line to your application's Gemfile:

    gem 'whirl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install whirl

## Usage

Step one: load Whirl:

    require 'whirl'

Step two: define a job that does an action

    class Whirl::Job::GoDoSomething < Whirl::Job::Base
      action do
        # Monitor a website, make api calls, send emails...
        say "HA HA! _BUSINESS_", :red # see: http://i.imgur.com/EFcX1.jpg
      end
    end

Step three: Run Whirl. e.g.:

    # Rakefile
    require 'rake'
    require 'whirl'
    require 'job/go_do_something' # job we defined above

    desc "Whirl"
    task :whirl { Whirl.run }

    # from terminal
    rake whirl # <= Runs jobs continuously.

## TODO

- Finish documentation
- Detailed usage examples

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
