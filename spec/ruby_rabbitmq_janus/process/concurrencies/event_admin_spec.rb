# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Process::Concurrencies::EventAdmin, type: :thread,
                                                                name: :event_admin,
                                                                retry: 3 do
  let(:publish_name) { :pub_admin }
  let(:listener) { RubyRabbitmqJanus::Rabbit::Listener::FromAdmin }
  let(:exception_runner) { RubyRabbitmqJanus::Errors::Process::EventAdmin::Run }

  include_examples 'when thread basic'
  include_examples 'when thread listen queue'
end
