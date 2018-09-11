# Hesh

Hesh makes Hashes. That's it for now. I may come up with something more clever later.

## Usage

Run down of the functions:

```ruby
# Makes a new Hash with default values of a new array
Hesh.of_array # == Hash.new { |h,k| h[k] = [] }

# Makes a new Hash with default values of a new hash
Hesh.of_hash # == Hash.new { |h,k| h[k] = {} }

# Makes a new Hash with default values of a new hash
Hesh.of_infinite_hash # == Hash.new { |h,k| h[k] = Hash.new(&h.default_proc) }

# Gets counts from a list, assumes identity function if no block given
Hesh.count_from(%w(a a a b b b b c c))
=> {"a"=>3, "b"=>4, "c"=>2}

# Inverts the relation of a hash
Hesh.invert_relation({ 1 => %w(a b), 2 => %w(b c), 3 => %w(a c) })
=> { "a" => [1, 3], "b" => [1, 2], "c" => [2, 3] }
```

More examples to come later

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hesh'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hesh

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/baweaver/hesh. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Hesh project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/baweaver/hesh/blob/master/CODE_OF_CONDUCT.md).
