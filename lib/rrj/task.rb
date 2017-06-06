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

    # Start a transaction with Janus. Request use session_id information.
    #
    # @param [Hash] options
    #   Give a session number for use another session in Janus
    #
    # @example Get Janus information
    #   @rrj.start_transaction do |transaction|
    #     response = transaction.publish_message('base::info').to_hash
    #   end
    #
    # @since 2.1.0
    def start_transaction(options = {})
      transaction = Janus::Transactions::Session.new(true,
                                                     options['session_id'])
      transaction.connect { yield(transaction) }
    rescue
      raise Errors::RRJ::StartTransaction.new(true, options)
    end

    # Create a transaction betwwen apps and janus with a handle
    #
    # @since 2.1.0
    def start_transaction_handle(exclusive = true, options = {})
      session = Models::JanusInstance.find_by(options['instance']).session
      handle = 0 # Create always a new handle
      transaction = Janus::Transactions::Handle.new(exclusive, session, handle)
      transaction.connect { yield(transaction) }
    rescue
      raise Errors::RRJTask::StartTransactionHandle, exclusive, options
    end
  end
end