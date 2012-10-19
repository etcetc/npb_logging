# NpbLogging

This is a simple logging module that inserts a seperator in the log file, adds the user_id and ip addresses to the start and end lines of an action
if they are present, and supports the addition of log notes

## Installation

Add this line to your application's Gemfile:

    gem 'npb_logging'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install npb_logging

## Usage

You must initialize the logger by adding a file in your initializers directory with the following line:

    require "npb_logging"
    NpbLogging.setup


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
