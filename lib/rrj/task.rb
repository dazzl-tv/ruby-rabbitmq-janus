# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT jeremy <jeremy.vaillant@dazl.tv>

  # # RubyRabbitmqJanus - Task
  #
  # This class is used with rake task.
  class RRJTask < RRJ
    def initialize
      Tools::Log.instance
      Tools::Config.instance
      Tools::Requests.instance
    rescue
      raise Errors::RRJTask::Initialize
    end

    # Create a transaction betwwen apps and janus with a handle
    #
    # @since 2.1.0
    def start_transaction_handle(exclusive = true, options = {})
      session = Tools::Cluster.instance.find_sessions(options['instance'])
      handle = 0 # Create always a new handle
      transaction = Janus::Transactions::Handle.new(exclusive, session, handle)
      transaction.connect { yield(transaction) }
    rescue
      raise Errors::RRJTask::StartTransactionHandle, exclusive, options
    end
  end
end
