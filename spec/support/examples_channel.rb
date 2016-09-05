# frozen_string_literal: true

shared_examples 'request channel' do |type, type_request|
  let(:transaction) { RRJ::RRJ.new }
  let(:option_control) { { strict: true, validate_schema: true } }

  it "type #{type_request}", type: type do
    expect(response).to match_json_schema(type.gsub('::', '_').to_sym, option_control)
  end
end
