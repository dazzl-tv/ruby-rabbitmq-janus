# frozen_string_literal: true

shared_examples 'test convert type' do |klass|
  let(:configuration) { '.travis/default.yml' }
  let(:request) { 'test::type' }

  let(:converter) do
    # Override configuration custom
    stub_const('RubyRabbitmqJanus::Tools::Config::CONF_CUSTOM', configuration)
    # Get request JSON file
    rqe = RubyRabbitmqJanus::Tools::Requests.instance.requests[request]
    # Open request file
    RubyRabbitmqJanus::Tools::Type.new(JSON.parse(File.read(rqe)))
  end
  let(:option) { { key => value } }
  let(:value_test) { defined?(value_return) ? value_return : value }

  it { expect(converter.convert(key, option)).to be_kind_of(klass) }
  it { expect(converter.convert(key, option)).to eql(value_test) }
end
