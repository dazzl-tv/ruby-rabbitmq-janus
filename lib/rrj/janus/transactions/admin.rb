# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # This class work with janus and send a series of message
      class Admin < Handle
        # Publish an message in handle
        #
        # @param [String] type
        #   Given a type to request. JSON request writing in 'config/requests/'
        # @param [Hash] options Replace/add element to request
        #
        # @return [Janus::Response::Standard] a response to message pusblishing
        #   in queue Admin API
        def publish_message_handle(type, options)
          opts = {
            'session_id' => session,
            'handle_id' => handle,
            'admin_secret' => admin_secret
          }
          msg = Janus::Messages::Admin.new(type, opts.merge!(options))
          Janus::Responses::Standard.new(read_response(publisher.publish(msg)))
        end

        private

        # Define queue used for admin message
        def choose_queue
          chan = rabbit.channel
          @publisher = Rabbit::Publisher::PublisherAdmin.new(chan)
        end

        # Override method for publishing an message and reading a response
        def send_a_message
          Tools::Log.instance.info 'Publish a message ...'
          Janus::Responses::Standard.new(publisher.publish(yield))
        end

        # Read a admin pass in configuration file to this gem
        def admin_secret
          Tools::Config.instance.options['rabbit']['admin_pass']
        end
      end
    end
  end
end
