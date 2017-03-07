# frozen_string_literal: true

shared_examples 'test convert type' do |klass|
  let(:request) { 'test::type' }

  let(:converter) do
    # Get request JSON file
    rqe = RubyRabbitmqJanus::Tools::Requests.instance.requests[request]
    # Open request file
    RubyRabbitmqJanus::Tools::Type.new(JSON.parse(File.read(rqe)))
  end
  let(:option) { { key => value } }
  let(:value_test) { defined?(value_return) ? value_return : value }

  it do
    expect(converter.convert(key, option)).to be_kind_of(klass)
  end
  it do
    expect(converter.convert(key, option)).to eql(value_test)
  end
end
