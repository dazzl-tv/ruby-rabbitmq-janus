# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

  # # RubyRabbitmqJanus - RRJTaskAdmin
  #
  # Used wit sidekiq/console/CI execution for admin queue in Janus gateway
  class RRJTaskAdmin < RRJTask
    # Crate a transaction between apps and Janus
    def start_transaction_admin(options = {})
      transaction = Janus::Transactions::Admin.new(options)
      transaction.connect { yield(transaction) }
    rescue
      raise Errors::RRJAdmin::StartTransactionAdmin, options
    end
  end
end
