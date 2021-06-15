# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Process::Concurrencies::Event, type: :thread,
                                                           name: :event do
  let(:publish_name) { :pub_classic }
  let(:listener) { RubyRabbitmqJanus::Rabbit::Listener::From }
  let(:exception_runner) { RubyRabbitmqJanus::Errors::Process::Event::Run }

  include_examples 'when thread basic'
  include_examples 'when thread listen queue'
end
