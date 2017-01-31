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
            @publisher = Rabbit::Publisher::PublisherAdmin.new(rabbit.channel)
            create_handle if @handle.eql?(0)
            yield
          end
        end

        def publish_message(type, options = {})
          msg = Janus::Messages::Admin.new(type, opts.merge(options))
          response = read_response(publisher.publish(msg))
          Janus::Responses::Standard.new(response)
        end

        private

        # Override method for publishing an message and reading a response
        def send_a_message
          Janus::Responses::Standard.new(publisher.publish(yield))
        end

        # Read a admin pass in configuration file to this gem
        def admin_secret
          Tools::Config.instance.options['rabbit']['admin_pass']
        end

        # :reek:NilCheck
        def opts
          hash = { 'session_id' => session, 'admin_secret' => admin_secret }
          hash.merge('handle_id' => @handle) unless @handle.nil?
          hash
        end
      end
    end
  end
end
