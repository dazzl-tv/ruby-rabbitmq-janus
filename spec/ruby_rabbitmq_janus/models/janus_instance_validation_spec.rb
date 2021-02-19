# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Models::JanusInstance, type: :model,
                                                   name: :janus_instance do
  before { described_class.delete_all }

  after do
    described_class.delete_all
    helper_janus_instance_without_token
  end

  let(:janus_id) do
    random_instance = [1, 2].sample

    if ENV['MONGO'].match?('true')
      { _id: random_instance.to_s }
    else
      { id: random_instance }
    end
  end
  let(:model) { described_class }

  context 'when Janus Instance simple transaction' do
    it { expect(model.count).to eq(0) }
  end

  context 'when many janus instances' do
    before do
      FactoryBot.create_list(:janus_instance, 5, enable: false)

      if ENV['MONGO'].match?('true')
        FactoryBot.create(:janus_instance, janus_id)
      else
        FactoryBot.create(:janus_instance)
      end
    end

    let(:one) { model.enabled.first }

    it { expect(model.count).to eq(6) }
    it { expect(model.enabled.count).to eq(1) }
    it { expect(model.find_by_instance(one.instance).session).to eq(one.session) }
  end

  context 'when Janus Instance enable' do
    let(:janus) { FactoryBot.create(:janus_instance, janus_id) }

    it { expect(janus.valid?).to be_a(TrueClass) }
    it { expect(janus.session).to be_a(Integer) }
    it { expect(janus.session).to eq(janus.session_id) }
    it { expect(janus.enable).to be_a(TrueClass) }
    it { expect(janus.name).to be_a(String) }
    it { expect(janus.name).to eq(janus.title) }
    it { expect(janus.id).to eq(janus.instance) }
    it { expect(janus.enable).to eq(true) }
  end

  context 'when Janus Instance disable' do
    let(:janus) { FactoryBot.create(:janus_instance, enable: false) }

    it { expect(janus.valid?).to be_a(TrueClass) }
    it { expect(janus.session).to be_a(Integer) }
    it { expect(janus.session).to eq(janus.session_id) }
    it { expect(janus.enable).to be_a(FalseClass) }
    it { expect(janus.name).to be_a(String) }
    it { expect(janus.name).to eq(janus.title) }
    it { expect(janus.id).to eq(janus.instance) }
    it { expect(janus.enable).to eq(false) }
  end
end
