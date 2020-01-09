# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Listener
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # This publisher don't post message. Is listen just an standard queue to
      # Janus. By default is "from-janus". It's a parameter in config to this
      # gem.
      class From < Base
        private

        def reply
          rabbit.queue(Tools::Config.instance.queue_from)
        end

        def response_class(payload)
          Janus::Responses::Event.new(JSON.parse(payload))
        end
      end
    end
  end
end
