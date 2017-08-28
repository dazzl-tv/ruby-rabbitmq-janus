# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Models::JanusInstance, type: :model,
                                                   name: :janus_instance do
  let(:janus_id) {
    random_instance = [1, 2].sample

    if ENV['MONGO'].match?('true')
      { _id: random_instance.to_s }
    else
      { id: random_instance }
    end
  }
  let(:model) { RubyRabbitmqJanus::Models::JanusInstance }
  let(:janus) { model.create }

  context 'Janus Instance simple transaction' do
    it do
      expect(model.count).to eq(2)
    end

    it do
      model.destroy_all
      expect(model.count).to eq(0)
    end

    it do
      expect(janus).to be_invalid
    end

    context 'Janus Instance is enable' do
      let(:janus) { model.create(janus_id.merge(enable: true)) }
      let(:instance) { model.last }

      it do
        janus.save
        expect(janus.valid?).to be_valid
      end

      it do
        expect(model.count).to eq(1)
      end

      it do
        expect(instance.session).to be_a(Integer)
      end

      it do
        expect(instance.enable).to be_a(TrueClass)
        expect(instance.enable).to eq(true)
      end

      it do
        expect(instance.thread).to be_a(Integer)
      end
    end

    context 'Janus Instance is disable' do
      let(:janus) { model.create(enable: false) }
      let(:instance) { model.last }

      it do
        janus.save
        expect(janus.valid?).to be_valid
      end

      it do
        expect(model.count).to eq(2)
      end

      it do
        expect(instance.session).to be_nil
      end

      it do
        expect(instance.enable).to be_a(FalseClass)
        expect(instance.enable).to eq(false)
      end

      it do
        expect(model.last.thread).to be_nil
      end
    end
  end
end
