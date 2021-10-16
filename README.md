# RubyCExperiments

Ruby gem that provides implementation examples of Ruby C Extensions and Foreign Function Interface (FFI)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_c_experiments'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_c_experiments

## Rake tasks

```

rake ruby_c_experiments:benchmarks:levenshtein_distance      # Levenshtein distance benckmarks
rake ruby_c_experiments:ffi:compile                          # Compile all the extensions
rake ruby_c_experiments:ffi:compile:levenshtein              # Compile levenshtein
rake ruby_c_experiments:native:compile                       # Compile all the extensions
rake ruby_c_experiments:native:compile:levenshtein_distance  # Compile levenshtein_distance

rake spec                                                    # Run tests

```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruby_c_experiments.
