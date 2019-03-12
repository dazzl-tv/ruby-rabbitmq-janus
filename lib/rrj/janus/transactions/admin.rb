# frozen_string_literal: true

# :reek:UncommunicativeMethodName

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # This class work with janus and send a series of message
      class Admin < Session
        def initialize(session)
          super(true, session)
        rescue
          raise Errors::Janus::TransactionAdmin::Initialize
        end

        # Begin connection with RabbitMQ
        def connect
          rabbit.transaction_short do
            @publisher = Rabbit::Publisher::PublisherAdmin.new(rabbit.channel)
            yield
          end
        rescue
          raise Errors::Janus::TransactionAdmin::Connect
        end

        # Write a message in queue in RabbitMQ
        def publish_message(type, options = {})
          msg = Janus::Messages::Admin.new(type, options.merge(opts2))
          response = read_response(publisher.publish(msg))
          Janus::Responses::Admin.new(response)
        rescue
          raise Errors::Janus::TransactionAdmin::PublishMessage
        end

        private

        def send_a_message
          Janus::Responses::Admin.new(publisher.publish(yield))
        end

        def admin_secret
          Tools::Config.instance.options['rabbit']['admin_pass']
        end

        def opts
          { 'session_id' => session, 'admin_secret' => admin_secret }
        end

        def opts2
          session.merge('admin_secret' => admin_secret)
        end
      end
    end
  end
end
