# frozen_string_literal: true

shared_examples 'file is found' do
  it 'should a true' do
    expect(file?(file)).to be true
  end
end

shared_examples 'request simple' do |type|
  let(:transaction) { RRJ::RRJ.new }
  let(:option_control) { { strict: true, validate_schema: true } }

  it "type #{type}" do
    expect(response).to match_json_schema(type, option_control)
  end
end
