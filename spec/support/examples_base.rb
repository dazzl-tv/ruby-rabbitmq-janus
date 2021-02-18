# frozen_string_literal: true

RSpec.shared_context 'with instance' do
  let(:instance) { RubyRabbitmqJanus::Models::JanusInstance.find(number) }
  let(:opt_instance) { { 'instance' => instance.id.to_s } }
  let(:opt_message) { opt_instance.merge!(parameter) }
end

## Transaction EXCLUSIVE ###
############################

RSpec.shared_context 'when transaction exclusive' do
  let(:transaction) do
    response = nil

    RubyRabbitmqJanus::RRJ.new.session_endpoint_private(opt_instance) do |tr|
      response = tr.publish_message(type, opt_message)
    end

    response
  end
end

RSpec.shared_examples 'when transaction exclusive success' do
  include_examples 'with instance'
  include_examples 'when transaction exclusive'

  it { expect(transaction.to_json).to match_json_schema(schema_success) }
end

RSpec.shared_examples 'when transaction exclusive exception' do
  include_examples 'with instance'
  include_examples 'when transaction exclusive'

  it { expect { transaction }.to raise_error(exception_class, exception_message) }
end

## Transaction NOT EXCLUSIVE
############################

RSpec.shared_context 'when transaction not exclusive' do
  let(:transaction) do
    response = nil

    RubyRabbitmqJanus::RRJ.new.session_endpoint_public(opt_instance) do |tr|
      response = tr.publish_message(type, opt_message)
    end

    response
  end
end

RSpec.shared_examples 'when transaction not exclusive success' do
  include_examples 'with instance'
  include_examples 'when transaction not exclusive'

  it { expect(transaction.to_json).to eql('{}') }
end

RSpec.shared_examples 'when transaction not exclusive exception' do
  include_examples 'with instance'
  include_examples 'when transaction exclusive'

  it { expect { transaction }.to raise_error(exception_class, exception_message) }
end
