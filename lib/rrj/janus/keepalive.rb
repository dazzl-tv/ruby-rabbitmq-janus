# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Manage sending keepalive message
  # :reek:TooManyInstanceVariables { max_instance_variables: 6 }
  class Keepalive
    # Initalize a keepalive message
    def initialize
      @response, @publish = nil
      @rabbit = Rabbit::Connect.new
      @lock = Mutex.new
      @condition = ConditionVariable.new
      session_live
    end

    # Return an number session created
    def session
      Log.instance.debug 'Waiting response for number session created'
      @lock.synchronize { @condition.wait(@lock) }
      Log.instance.debug 'Response is here'
      @response.session
    end

    private

    # Send to regular interval a message keepalive
    def session_live
      Thread.new do
        Log.instance.debug 'Create an session for keepalive'
        initialize_thread
      end
    end

    # Initialize an session with janus and start a keepalive transaction
    def initialize_thread
      @rabbit.start
      @response = session_start
      @lock.synchronize { @condition.signal }
      session_keepalive(ttl)
      @rabbit.close
    end

    # Star an session janus
    def session_start
      msg_create = Message.new 'create'
      @publish = Rabbit::PublishExclusive.new(@rabbit.channel, '')
      RubyRabbitmqJanus::Response.new @publish.send_a_message(msg_create)
    end

    # Create an loop for sending a keepalive message
    def session_keepalive(time_to_live)
      loop do
        sleeping time_to_live
        @publish.send_a_message(Message.new('keepalive',
                                            'session_id' => @response.session))
      end
    rescue => message
      Log.instance.debug "Error keepalive : #{message}"
    end

    # Define a Time To Live between each request sending to janus
    def ttl
      time_to_live = Config.instance.options['gem']['session']['keepalive'].to_i
      Log.instance.debug "Starting a thread keepalive with interval : #{time_to_live}"
      time_to_live
    end

    def sleeping(time)
      time.downto 1 do |seconde|
        Log.instance.debug seconde
        sleep 1
      end
    end
  end
end
