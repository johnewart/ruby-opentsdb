# OpenTSDB Ruby client
[![Build
Status](https://travis-ci.org/johnewart/ruby-opentsdb.svg?branch=master)](https://travis-ci.org/johnewart/ruby-opentsdb)

## What is this?

This is a Ruby client for simplifying interactions with OpenTSDB

## What does it do?

As of this instant, not a whole lot except wrap the "put" method in a 
quick-and-dirty style. This will eventually grow to be much more useful 
as I expand functionality. 

## Quick example

    @client = OpenTSDB::Client.new({:hostname => 'localhost', :port => 4242})

    sample = { :metric => 'double_rainbow.count', :value => 42, :timestamp => Time.now.to_i, :tags => {:factor => 'awesome', :host => 'ponies' } }
    @client.put(sample)


## License

Copyright 2012 John Ewart <john@johnewart.net>. Released under the MIT license. See the file LICENSE for further details.
