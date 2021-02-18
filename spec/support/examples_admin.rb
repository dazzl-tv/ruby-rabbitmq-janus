# frozen_string_literal: true

# Shared example for ADMIN request
# Prepare Janus instance with data before
# execute transaction or other test.

RSpec.shared_context 'when transaction admin' do
  let(:transaction) do
    response = nil

    RubyRabbitmqJanus::RRJAdmin.new.admin_endpoint(opt_instance) do |tr|
      response = tr.publish_message(type, opt_message)
    end

    response
  end
end

RSpec.shared_examples 'when transaction admin exception' do
  include_examples 'with instance'
  include_examples 'when transaction admin'

  it { expect { transaction }.to raise_error(exception_class, exception_message) }
end

RSpec.shared_examples 'when transaction admin success' do
  include_examples 'with instance'
  include_examples 'when transaction admin'

  it { expect(transaction.to_json).to match_json_schema(schema_success) }
end

RSpec.shared_examples 'when transaction admin success info' do
  include_examples 'when transaction admin success'

  it { expect(transaction.send(info)).to be_a(info_type) }
end

RSpec.shared_examples 'when transaction admin success boolean' do
  include_examples 'when transaction admin success'

  it { expect(transaction.send(info)).to be_in([true, false]) }
end
