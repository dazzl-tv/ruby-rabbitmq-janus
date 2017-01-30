# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # This class work with janus and send a series of message
      class Admin < Session
        def initialize(session, handle = nil)
          super(session)
          @exclusive = true
          @handle = handle
        end

        def connect
          rabbit.transaction_short do
            choose_queue
            create_handle if @handle.eql?(0)
            yield
          end
        end

        def publish_message_handle(type, options)
          publish_message(type, opts_complex.merge!(options))
        end

        def publish_message_session(type, options)
          publish_message(type, opts_simple.merge(options))
        end

        private

        def publish_message(type, options)
          msg = Janus::Messages::Admin.new(type, options)
          response = read_response(publisher.publish(msg))
          Janus::Responses::Standard.new(response)
        end

        # Define queue used for admin message
        def choose_queue
          chan = rabbit.channel
          @publisher = Rabbit::Publisher::PublisherAdmin.new(chan)
        end

        # Override method for publishing an message and reading a response
        def send_a_message
          Janus::Responses::Standard.new(publisher.publish(yield))
        end

        # Read a admin pass in configuration file to this gem
        def admin_secret
          Tools::Config.instance.options['rabbit']['admin_pass']
        end

        def opts_simple
          { 'session_id' => session, 'admin_secret' => admin_secret }
        end

        def opts_complex
          opts_simple.merge('handle_id' => handle)
        end
      end
    end
  end
end
