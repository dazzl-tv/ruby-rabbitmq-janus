# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # This class work with janus and send a series of message
      class Admin < Session
        def initialize(session)
          super(true, session)
        end

        def connect
          rabbit.transaction_short do
            @publisher = Rabbit::Publisher::PublisherAdmin.new(rabbit.channel)
            yield
          end
        end

        def publish_message(type, options = {})
          msg = Janus::Messages::Admin.new(type, opts.merge(options))
          response = read_response(publisher.publish(msg))
          Janus::Responses::Admin.new(response)
        end

        private

        # Override method for publishing an message and reading a response
        def send_a_message
          Janus::Responses::Admin.new(publisher.publish(yield))
        end

        # Read a admin pass in configuration file to this gem
        def admin_secret
          Tools::Config.instance.options['rabbit']['admin_pass']
        end

        # :reek:NilCheck
        def opts
          { 'session_id' => session, 'admin_secret' => admin_secret }
        end
      end
    end
  end
end
