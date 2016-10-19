# frozen_string_literal: true
# :reek:InstanceVariableAssumption

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # This class work with janus and send a series of message
    class TransactionCallbacks
      include ActiveSupport::Callbacks
      define_callbacks :transaction_start
      define_callbacks :transaction_close

      def transaction_start
        run_callbacks :transaction_start do
          Tools::Log.instance.debug 'Start a transaction ....'
          @rabbit.start
          @publish = publisher
        end
      end

      def transaction_close
        run_callbacks :transaction_close do
          @rabbit.close
          Tools::Log.instance.debug 'Close a transaction ....'
        end
      end

      set_callback :transaction_start, :handle_running, :before
      set_callback :transaction_close, :handle_running, :after
    end
  end
end
