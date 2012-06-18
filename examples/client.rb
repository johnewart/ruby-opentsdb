require 'rubygems'
$:.unshift File.dirname(__FILE__) + "/../lib"
require 'opentsdb'

@client = OpenTSDB::Client.new({:hostname => 'localhost', :port => 4242})

sample = { :metric => 'double_rainbow.count', :value => 42, :timestamp => Time.now.to_i, :tags => {:factor => 'awesome', :host => 'ponies' } }
@client.put(sample)
