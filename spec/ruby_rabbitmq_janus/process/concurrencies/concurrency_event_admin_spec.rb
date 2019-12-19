# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Process::Concurrencies::EventAdmin, type: :thread,
                                                                name: :event_admin do
  let(:publish_name) { :publish_adm }
  let(:listener) { RubyRabbitmqJanus::Rabbit::Listener::FromAdmin }
  let(:exception_runner) { RubyRabbitmqJanus::Errors::Process::EventAdmin::Run }

  include_examples 'when thread'
end
