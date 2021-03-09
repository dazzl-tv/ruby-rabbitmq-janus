# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Process::Concurrencies::Concurrency, type: :thread,
                                                                 name: :concurrency,
                                                                 retry: 3 do
  include_examples 'when thread basic'
end
