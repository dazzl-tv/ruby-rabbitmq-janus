# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Process::Concurrencies::Concurrency, type: :thread,
                                                                 name: :concurrency do
  include_examples 'when thread basic'
end
