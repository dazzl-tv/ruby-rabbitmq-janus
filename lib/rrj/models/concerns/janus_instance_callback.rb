# frozen_string_literal: true

# :reek:UtilityFunction

# rubocop:disable Style/GuardClause

module RubyRabbitmqJanus
  module Models
    # Add method for JanusInstance model
    module JanusInstanceCallback
      def callback_create_after
        create_janus_session if enable
      end

      def callback_update_after
        if enable_changed?
          enable ? create_janus_session : destroy_janus_session
        end
      end

      def callback_destroy_before
        destroy_janus_session if enable && session? && thread?
      end

      private

      # Create an session in Janus Instance and save references in database
      def create_janus_session
        thread = initialize_thread

        set(thread: thread.object_id)
        set(session: thread.session)
        set(enable: true)
      end

      # Send an action for destroying a session in Janus Gateway instance
      # and kill the thread managing session
      def destroy_janus_session
        options = { 'session_id' => session, 'instance' => instance }

        search_initializer(options) do |transaction|
          transaction.publish_message('base::destroy', options)
        end

        ObjectSpace._id2ref(thread).stop
      end
    end
  end
end
# rubocop:enable Style/GuardClause
