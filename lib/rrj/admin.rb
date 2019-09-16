# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

  # # RubyRabbitmqJanus - RRJAdmin
  #
  # This class inherite to a classic initializer but it's used for
  # admin request sending to janus (Admin/Monitor API).
  #
  # **Is used just for sending a message to Janus Monitor/Admin API.**.
  # **The queue is always ***exclusive*** for not transmitting data to
  # anyone.**
  #
  # @see https://janus.conf.meetecho.com/docs/admin.html
  class RRJAdmin < RRJ
    # Create a transaction between apps and Janus for request without handle
    #
    # @param [Hash] options
    #   Give a session number for use another session in Janus
    #
    # @example Get Janus session
    #   @rrj.start_transaction_admin do |transaction|
    #     response = transaction.publish_message('admin:sessions').sessions
    #   end
    #
    # @since 2.0.0
    # @deprecated Use {#admin_endpoint} instead.
    def start_transaction_admin(options = {})
      transaction = Janus::Transactions::Admin.new(options)
      transaction.connect { yield(transaction) }
    rescue
      raise Errors::RRJAdmin::StartTransactionAdmin, options
    end

    # Create a transaction between Apps and Janus
    #
    # @param [Hash] options
    #   Give a session number for use another session in Janus
    #
    # @example List all sessions in Janus Instance
    #   instance = { 'instance' => 42 }
    #   @rrj.admin_endpoint(instance) do |transaction|
    #     response = transaction.publish_message('admin:sessions').sessions
    #   end
    #
    # @example Change log level to Janus Instance
    #   instance = { 'instance' => 42 }
    #   options = instance.merge({ 'level' => 5 })
    #   @rrj.admin_endpoint(options) do |transaction|
    #     response = transaction.publish_message('admin:set_log_level', options)
    #   end
    #
    # @since 2.7.0
    def admin_endpoint(options = {})
      transaction = Janus::Transactions::Admin.new(options)
      transaction.connect { yield(transaction) }
    rescue
      raise Errors::RRJAdmin::StartTransactionAdmin, options
    end
  end
end
