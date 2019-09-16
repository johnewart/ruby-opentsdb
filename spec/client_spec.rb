require 'spec_helper.rb'

describe OpenTSDB::Client do
  let(:socket) { double('socket').as_null_object }
  let(:client) { described_class.new }

  before(:each) do
    allow(TCPSocket).to receive(:new).and_return(socket)
  end

  describe '#initialize' do
    subject { client }

    it 'creates a new client' do
      expect { subject }.to_not raise_error
    end

    it 'raises a custom error if the connection failed' do
      expect(TCPSocket).to receive(:new).and_raise('connection error')

      expect { subject }.to raise_error(OpenTSDB::Errors::UnableToConnectError)
    end
  end

  describe '#put' do
    let(:metric) do
      { timestamp: 1_411_104_988, metric: 'users', value: 100, tags: { foo: 'bar' } }
    end

    let(:other_metric) do
      { timestamp: 1_411_104_999, metric: 'users', value: 150, tags: { bar: 'baz' } }
    end

    describe 'error handling' do
      context 'no tags' do
        subject { client.put({}) }

        it { expect { subject }.to raise_error(OpenTSDB::Errors::InvalidTagsError) }
      end

      context 'tags' do
        subject { client.put(metric.merge(tags: tags)) }

        context 'empty tags' do
          let(:tags) { {} }

          it { expect { subject }.to raise_error(OpenTSDB::Errors::InvalidTagsError) }
        end

        context 'invalid tags' do
          let(:tags) { [:test, 123] }

          it { expect { subject }.to raise_error(OpenTSDB::Errors::InvalidTagsError) }
        end
      end
    end

    context 'one metric' do
      subject { client.put(metric) }

      it 'writes a single metric to the socket' do
        expect(socket).to receive(:puts).with('put users 1411104988 100.0 foo=bar')

        subject
      end
    end

    context 'many metrics' do
      subject { client.put([metric, other_metric]) }

      it 'writes multiple metrics to the socket' do
        expect(socket).to receive(:puts).with(
          "put users 1411104988 100.0 foo=bar\nput users 1411104999 150.0 bar=baz"
        )

        subject
      end
    end
  end
end
