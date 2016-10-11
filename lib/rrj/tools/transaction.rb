# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # This class work with janus and send a series of message
  class Transaction
    def initialize(session)
      Log.instance.debug 'Transaction is started'
      @rabbit = Rabbit::Connect.new
      @rabbit.start
      @publish = publisher
      @session = session
      @handle = nil
    end

    def handle_running(type, options)
      @handle = publish_message_session('attach').sender
      response = publish_message_handle(type, options)
      @rabbit.close
      response.to_hash
    end

    private

    def publish_message_session(type)
      msg = Message.new(type, 'session_id' => @session)
      Response.new(@publish.send_a_message(msg))
    end

    def publish_message_handle(type, options = {})
      opts = { 'session_id' => @session, 'handle_id' => @handle }
      msg = Message.new(type, opts.merge!(other: options))
      Response.new(@publish.send_a_message(msg))
    end

    def publisher
      Rabbit::PublishExclusive.new(@rabbit.channel, '')
    end
  end
end
