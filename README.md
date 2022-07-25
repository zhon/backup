# Backup

Backup is used to keep Lightroom Photos and catalog backed up to individual smaller drives by year.

This assumes Lightroom is on one drive called Media and the Backup drives are called M followed by the last two digits of the year (i.e., M20 is for year 2020) or the followed by a dash and another digit (i.e., M21-2)



## Installation

    $ gem install backup

## Usage

    $bin/backup help backup

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/backup.

## Todo

Allow Mappings to come from a config file.

Don't backup a corrupted file (I don't know how to do this yet).
