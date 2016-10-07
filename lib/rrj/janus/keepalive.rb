# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Manage sending keepalive message
  class Keepalive
    def initialize
      Log.instance.info 'Start a seesion keepalive'
      @rabbit = Rabbit::Connect.new
      @rabbit.start
      session_start
      session_live
    end

    private

    # Star an session janus
    # Create -> Keepalive -> destroy
    def session_start
      msg_create = Message.new 'create'
      publish = Rabbit::PublishReply.new(@rabbit.channel)
      publish.send_a_message(msg_create)
    end

    # Send to regular interval a message keepalive
    def session_live
      time_to_live = Config.instance.options['gem']['session']['keepalive'].to_i
      Thread.new do
        loop do
          session_keepalive
          sleep time_to_live
        end
      end
    end

    def sesion_keepalive
      Log.instance.unknown 'send message keepalive'
      msg_keep = Message.new 'keepalive'
      publish = Rabbit::PublishReply.new(@rabbit.channel)
      publish.send_a_message(msg_keep.to_json, Propertie.new)
    end
  end
end
