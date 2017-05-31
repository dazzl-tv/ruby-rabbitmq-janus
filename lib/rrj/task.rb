# frozen_string_literal: true

module RubyRabbitmqJanus
  class Task < RRJ
    def initialize
      Tools::Log.instance
      Tools::Config.instance
      Tools::Requests.instance
    end

    def start_transaction_handle(exclusive = true, options = {})
      Tools::Log.instance.info "Execute action for intsance : #{options['instance']}"
      session = Tools::Cluster.instance.find_sessions(options['instance'])
      handle = 0
      transaction = Janus::Transactions::Handle.new(exclusive, session, handle)
      transaction.connect do
        yield(transaction)
      end
    end
  end
end
