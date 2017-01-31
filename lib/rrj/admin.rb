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
  # @example Create instance
  #   @rrj = RubyRabbitmqJanus::RRJAdmin.new
  #   => #<RubyRabbitmqJanus::RRJAdmin:0x...
  #     @option=#<RubyRabbitmqJanus::Tools::Option:0x... @hash={}>
  #     @session=3409659256174167>
  #
  #   @rrj.start_session_admin do |transaction|
  #     transaction.publish_message('admin::sessions')
  #   end
  #   => #<RubyRabbitmqJanus::Janus::Responses::Standard:0x...
  #     @request={"janus"=>"success", "sessions"=>[...]}>
  #
  # @see https://janus.conf.meetecho.com/docs/admin.html
  class RRJAdmin < RRJ
    # Create a transaction between apps and janus for request without handle
    #
    # @since 2.0.0
    def start_session_admin(options = {})
      opts = option.use_current_session?(options)
      transaction = Janus::Transactions::Admin.new(opts.hash)
      transaction.connect { yield(transaction) }
    end
  end
end
