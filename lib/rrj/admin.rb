# frozen_string_literal: true
# :reek:UtilityFunction

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
    # Send a message simple for admin Janus.
    #
    # @since 1.3.0
    def message_admin(type, transaction,
                      options = { 'replace' => {}, 'add' => {} })
      transaction.publish_message_session(type, options)
    end

    # Create a transaction between apps and janus for request without handle
    #
    # @since 1.3.0
    def start_session_admin(options = { 'replace' => {}, 'add' => {} })
      opts = use_current_session?(options)
      transaction = Janus::Transactions::Admin.new(opts)
      transaction.connect { yield(transaction) }
    end

    # Create a transaction between apps and janus for request with handle
    #
    # @since 1.3.0
    def start_handle_admin(options = { 'replace' => {}, 'add' => {} })
      opts = use_current_session?(options)
      transaction = Janus::Transactions::Admin.new(opts,
                                                   handle?(options))
      transaction.connect { yield(transaction) }
    end
  end
end
