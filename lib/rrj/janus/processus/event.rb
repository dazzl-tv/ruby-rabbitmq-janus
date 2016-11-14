# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  module Janus
    module Concurrencies
      # For listen standard queue ("from-janus" by default)
      # :reek:InstanceVariableAssumption and :reek:NilCheck
      # :reek:TooManyInstanceVariables and :reek:TooManyStatements
      class Event
        include Singleton

        # Initialize Event object. Is used for listen an standard out queue to Janus
        def initialize
          @publish = @response = nil
          Tools::Log.instance.info "Create an thread -- #{self.class.name}"
          @rabbit = Rabbit::Connect.new
          @lock = Mutex.new
          @condition = ConditionVariable.new
          @thread_subscribe = Thread.new { initialize_thread }
        end

        # Start listen queue and work with each message reading
        def listen(&block)
          @thread_subscribe.join
          puts 'LISTEN !!'
          @thread_listen = Thread.new do
            puts 'LISTEN in thread !!'
            Thread.pass
            @publish.event_received(&block)
          end
        end

        private

        # Initialize a thread
        def initialize_thread
          Thread.pass
          @rabbit.transaction_long do
            @publish = Rabbit::Publisher::Listener.new(@rabbit)
            @response = @publish.listen_events
            @thread_listen&.join # Call if not nil
          end
        rescue Interrupt
          Tools::Log.instance.info "Stop transaction #{self.class.name}"
          @rabbit.close
        end
      end
    end
  end
end
