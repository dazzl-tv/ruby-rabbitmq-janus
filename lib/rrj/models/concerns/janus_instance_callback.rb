# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  module Models
    # Add method for JanusInstance model
    module JanusInstanceCallback
      def callback_create_after
        Tools::Log.instance.debug 'Janus Instance Callback CREATE'
        create_janus_session if enable
      end

      def callback_update_after
        Tools::Log.instance.debug 'Janus Instance Callback UPDATE'
        enable ? create_janus_session : destroy_janus_session
      end

      def callback_destroy_before
        Tools::Log.instance.debug 'Janus Instance Callback DESTROY'
        destroy_janus_session if enable && session? && thread?
      end

      private

      # Create an session in Janus Instance and save references in database
      def create_janus_session
        Tools::Log.instance.debug 'Create Janus Session'
        thread = initialize_thread

        set(thread: thread.object_id)
        set(session: thread.session)
        set(enable: true)
      end

      # Send an action for destroying a session in Janus Gateway instance
      # and kill the thread managing session
      def destroy_janus_session
        Tools::Log.instance.debug 'Destroy Janus Session'
        options = { 'session_id' => session, 'instance' => instance }

        search_initializer(options) do |transaction|
          transaction.publish_message('base::destroy', options)
        end

        ObjectSpace._id2ref(thread).stop
      end
    end
  end
end
