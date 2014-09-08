# BAI Parser

Ruby BAI2 Bank File parser.  Takes a bank file as input and outputs the data as a Ruby hash.  You can then use a custom writer class to output the data as needed for your purposes.

## Installation

Add this line to your application's Gemfile:

    gem 'bai_parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bai_parser

## Usage

``` ruby
require "bai_parser"
data = BAI::Parser.parse "BAI-File-From-Bank.bai"

# Then you can use a custom writer to output the data as needed such as to a csv file
MyCustomBAIWriter.write data

# For a quick test to see the parsed data, run the executable against your data file and it will print the data to the screen
bai_parse bai-file.txt
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
