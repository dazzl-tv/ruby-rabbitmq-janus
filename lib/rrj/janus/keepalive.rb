# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Manage sending keepalive message
  class Keepalive
    def initialize
      @response, @publish = nil
      @rabbit = Rabbit::Connect.new
      session_live
    end

    private

    # Star an session janus
    # Create -> Keepalive -> destroy
    def session_start
      msg_create = Message.new 'create'
      @publish = Rabbit::PublishExclusive.new(@rabbit.channel, '')
      RubyRabbitmqJanus::Response.new @publish.send_a_message(msg_create)
    end

    # Send to regular interval a message keepalive
    def session_live
      Thread.new do
        Log.instance.debug 'Send keepalive session'
        initialize_thread
      end
    end

    def initialize_thread
      @rabbit.start
      @response = session_start
      session_keepalive(ttl)
      @rabbit.close
    end

    def ttl
      time_to_live = Config.instance.options['gem']['session']['keepalive'].to_i
      Log.instance.debug "Starting a thread keepalive with interval : #{time_to_live}"
      time_to_live
    end

    def session_keepalive(time_to_live)
      loop do
        sleep time_to_live
        @publish.send_a_message(Message.new('keepalive',
                                            'session_id' => @response.session))
      end
    rescue => message
      Log.instance.debug "Error keepalive : #{message}"
    end
  end
end
