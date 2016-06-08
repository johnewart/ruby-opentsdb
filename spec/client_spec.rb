require 'spec_helper.rb'

describe OpenTSDB::Client do
  let(:socket) { double('socket').as_null_object }
  let(:client) { described_class.new }

  before(:each) do
    allow(TCPSocket).to receive(:new).and_return(socket)
  end

  describe 'error handling' do
    subject { described_class.new }

    it 'raises a custom error if the connection failed' do
      expect(TCPSocket).to receive(:new).and_raise('connection error')

      expect { subject }.to raise_error(OpenTSDB::Errors::UnableToConnectError)
    end
  end

  it 'creates a new client' do
    expect { client }.to_not raise_error
  end

  it 'writes a single metric to the socket' do
    expect(socket).to receive(:puts).with('put users 1411104988 100.0 foo=bar')

    metric = {
      timestamp: 1411104988,
      metric: 'users',
      value: 100,
      tags: { foo: 'bar' },
    }

    client.put(metric)
  end

  it 'writes multiple metrics to the socket' do
    expect(socket).to receive(:puts).with(
      "put users 1411104988 100.0 foo=bar\nput users 1411104999 150.0 bar=baz"
    )

    metrics = [
      {
        timestamp: 1411104988,
        metric: 'users',
        value: 100,
        tags: { foo: 'bar' },
      },
      {
        timestamp: 1411104999,
        metric: 'users',
        value: 150,
        tags: { bar: 'baz' },
      },
    ]

    client.put(metrics)
  end
end
