# frozen_string_literal: true

shared_examples 'file is found' do
  it 'should a true' do
    expect(file?(file)).to be true
  end
end
