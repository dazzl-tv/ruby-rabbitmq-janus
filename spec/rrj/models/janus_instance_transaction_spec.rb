# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Models::JanusInstance, type: :model,
                                                   name: :janus_instance do
  before { RubyRabbitmqJanus::Models::JanusInstance.delete_all }

  let(:janus_id) {
    random_instance = [1, 2].sample

    if ENV['MONGO'].match?('true')
      { _id: random_instance.to_s }
    else
      { id: random_instance }
    end
  }
  let(:model) { RubyRabbitmqJanus::Models::JanusInstance }
  let(:janus) { FactoryGirl.create(:janus_instance, enable: false) }
  let(:many_janus) { FactoryGirl.create(:janus_isntance, 5, enable: false) }

  context 'Janus Instance simple transaction' do
    it { expect(model.count).to eq(0) }
  end

  context 'many janus instances' do
    before do
      FactoryGirl.create_list(:janus_instance, 5, enable: false)
      FactoryGirl.create(:janus_instance, janus_id)
    end

    let(:one) { model.enabled.first }

    it { expect(model.count).to eq(6) }
    it { expect(model.enabled.count).to eq(1) }
    it { expect(model.find_by_session(one.session).thread).to eq(one.thread) }
  end

  context 'Janus Instance enable' do
    let(:janus) { FactoryGirl.create(:janus_instance, janus_id) }

    it { expect(janus.valid?).to be_a(TrueClass) }
    it { expect(janus.session).to be_a(Integer) }
    it { expect(janus.enable).to be_a(TrueClass) }
    it { expect(janus.enable).to eq(true) }
    it { expect(janus.thread).to be_a(Integer) }
  end

  context 'Janus Instance disable' do
    let(:janus) { FactoryGirl.create(:janus_instance, enable: false) }

    it { expect(janus.valid?).to be_a(TrueClass) }
    it { expect(janus.session).to be_nil }
    it { expect(janus.enable).to be_a(FalseClass) }
    it { expect(janus.enable).to eq(false) }
    it { expect(janus.thread).to be_nil }
  end
end
