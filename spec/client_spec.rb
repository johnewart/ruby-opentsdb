require 'spec_helper.rb'

describe OpenTSDB::Client do
  before :each do 
    @socket = double('socket').as_null_object
    expect(TCPSocket).to receive(:new).and_return(@socket)
    @client = OpenTSDB::Client.new
  end
  
  it "should create a new client" do  
  end

  it "should write a single metric to the socket" do 
    expect(@socket).to receive(:puts).with("put users 1411104988 100.0 foo=bar")
    metric = {
      :timestamp => 1411104988,
      :metric => "users",
      :value => 100,
      :tags => { :foo => "bar" }
    }
    @client.put(metric)
  end

  it "should write multiple metrics to the socket" do
    expect(@socket).to receive(:puts).with("put users 1411104988 100.0 foo=bar\nput users 1411104999 150.0 bar=baz")
    metrics = []
    metrics << {
      :timestamp => 1411104988,
      :metric => "users",
      :value => 100,
      :tags => { :foo => "bar" }
    }

    metrics << {
      :timestamp => 1411104999,
      :metric => "users",
      :value => 150,
      :tags => { :bar => "baz" }
     }

    @client.put(metrics)
  
  end
  
end
