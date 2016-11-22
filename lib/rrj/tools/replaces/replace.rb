# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    module Replaces
      # Tools for replace elements in request sending to Rabbitmq
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class Replace
        # Initialize tool replace
        def initialize(request, options = {})
          @request = request
          @opts = options
          Tools::Log.instance.debug "Element to replace : #{@opts}"
        end

        # Replace element in hash request with information used for this transaction
        # @return HASH request with element replace
        def transform_request
          replace_classic
          unless @opts.empty?
            replace_other if test_presence?('replace')
            add_other if test_presence?('add')
          end
          @request
        end

        private

        attr_reader :request, :opts

        # Replace basic elements
        def replace_classic
          replace_transaction if @request.key?('transaction')
        end

        # Create an transaction string and replace in request field with an String format
        def replace_transaction
          @request['transaction'].replace [*('A'..'Z'), *('0'..'9')].sample(10).join
        rescue => message
          Tools::Log.instance.warn "Error transaction replace : #{message}"
        end
      end
    end
  end
end

require 'irrj/tools/replaces/standard'
require 'irrj/tools/replaces/admin'
