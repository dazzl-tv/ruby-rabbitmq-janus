# frozen_string_literal: true

module RubyRabbitmqJanus
  module ErrorRequest
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors with Rabbitmq when connection is failed
    class RequestTemplateNotExist < RRJError
      def initialize(request_name)
        super "The template request (#{request_name}) does not exist", :fatal
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors if request folder does not exist
    class RequestFolerDoesntExist < RRJError
      def initialize
        super 'The requests folder does not exist', :fatal
      end
    end
  end
end
