# BrakemanTranslateCheckstyleFormat

[![Gem Version](https://badge.fury.io/rb/brakeman_translate_checkstyle_format.svg)](http://badge.fury.io/rb/brakeman_translate_checkstyle_format)
[![Build Status](https://travis-ci.org/noboru-i/brakeman_translate_checkstyle_format.svg?branch=master)](https://travis-ci.org/noboru-i/brakeman_translate_checkstyle_format)
[![Code Climate](https://codeclimate.com/github/noboru-i/brakeman_translate_checkstyle_format/badges/gpa.svg)](https://codeclimate.com/github/noboru-i/brakeman_translate_checkstyle_format)
[![Coverage Status](https://coveralls.io/repos/noboru-i/brakeman_translate_checkstyle_format/badge.svg)](https://coveralls.io/github/noboru-i/brakeman_translate_checkstyle_format)

Translate brakeman json format into checkstyle format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'brakeman_translate_checkstyle_format'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brakeman_translate_checkstyle_format

## Usage

### Use pipe

```
brakeman -o brakeman.json
cat brakeman.json | brakeman_translate_checkstyle_format translate
```

### Use command-line option

```
brakeman -o brakeman.json
brakeman_translate_checkstyle_format translate --file="brakeman.json"
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/brakeman_translate_checkstyle_format. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

