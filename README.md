# Perceptron

The perceptron is a linear binary classifier. Given enough linearly separable data, it can find a decision boundary that allows predictions about unseen data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'perceptron'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install perceptron

## Usage

Instantiate a new Perceptron with the desired number of features to track.
```ruby
Perceptron.create(features_number)
  ```
The perceptron accepts a hash of the form {:vector => Vector[...], :expected => number} as training input.   
```ruby
Perceptron.train({:vector => Vector[0, 1, 0, 1], :expected => 0})
```
To make a prediction just write
```ruby
Perceptron.predict(Vector[0,3,6,7])
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/terminalobject/perceptron.

## Authors

* Alessandro Noiato - https://github.com/terminalobject
* Alistair Kung - https://github.com/alistairkung
* Corina Gheorge - https://github.com/corina
* Jini M. Coroneo - https://github.com/jinimcoroneo
* Tom Scanlon - https://github.com/tbscanlon

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
