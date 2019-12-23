# frozen_string_literal: true

RSpec.shared_examples 'when disable an instance' do
  before { session_id }

  it { expect { model.disable(session_id) }.to change { model.find_by_session(session_id).reload.enable }.from(true).to(false) }
end

RSpec.shared_examples 'when disable an instance not change' do
  before { session_id }

  it { expect { model.disable(session_id) }.not_to change { model.find_by_session(session_id).reload.enable }.from(false) }
end

RSpec.shared_examples 'when enable an instance not change' do
  before { session_id }

  it { expect { model.enable(session_id) }.not_to change { model.find_by_session(session_id).reload.enable }.from(true) }
end

RSpec.shared_examples 'when enable an instance' do
  before { session_id }

  it { expect { model.enable(session_id) }.to change { model.find_by_session(session_id).reload.enable }.from(false).to(true) }
end

RSpec.shared_examples 'when destroys all disable instance' do
  it { expect(model.destroys).to eql(count_destroyed) }
end

RSpec.shared_examples 'when search by instance' do
  it { expect(model.find_by_instance(id).instance).to eql(id) }
end

RSpec.shared_examples 'when search by session' do
  it { expect(model.find_by_session(session_id).session_id).to eql(session_id) }
end

RSpec.shared_examples 'when search instance enabled' do
  it { expect(model.enabled.count).to eql(count_enabled) }
end

RSpec.shared_examples 'when search instance disabled' do
  it { expect(model.disabled.count).to eql(count_disabled) }
end
