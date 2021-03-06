# Whirl

A watered-down gem for looping over jobs. Pre-wired with Redis and HTTParty. Built with Heroku usage in mind.

## Installation

Add this line to your application's Gemfile:

    gem 'whirl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install whirl

WARNING: Version 0.0.4 breaks the `Whirl::Redis.instance` api. This is no
longer using Ruby's singleton module. This is because when `instance` is called
from within a subclass of `Whirl::Job::Base` (which executes in a child
process), the parent process doesn't have access to that instance since there's
no shared memory.  Use `Whirl::Redis.new` instead. Also, within
`Whirl::Job::Base` subclasses, the following api is available within `action do; end`:

    action do
      redis #=> Whirl::Redis instance
    end

## Usage

A contrived example, but this is all you need:

```ruby
require 'whirl'

class Whirl::Job::DoBusiness < Whirl::Job::Base
  action do
    say "HA HA! _BUSINESS_: http://i.imgur.com/EFcX1.jpg", :red
  end
end

class Whirl::Job::MonitorSomeStuff < Whirl::Job::Base
  action do
    # Monitor a website, make api calls, send emails...
    say "Do ALL THE MONITORING!"
  end
end

# By default, Whirl runs jobs at an interval of 10 seconds. Change this via:

ENV['WHIRL_LOOP_INTERVAL'] = 60 # <= Whirl will now run jobs every 60 seconds

Whirl.run # <= continuously loops over the DoBusiness and MonitorSomeStuff jobs at the set interval
```

## TODO

- Finish documentation
- Detailed usage examples

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
