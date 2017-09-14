# frozen_string_literal: true

module RubyRabbitmqJanus
  # Contains all model for this gem
  module Models
    # Configure callback for Janus Instance models
    module JanusInstanceCallbacks
      extend ActiveSupport::Concern

      # Create a session in Janus Instance
      def callback_create_after
        Tools::Log.instance.debug 'Callback AFTER_VALIDATION'
        create_a_session_in_janus_instance if enable
      end

      # Update a keepalive transaction in Janus Instance
      # Enable or Disable transaction
      def callback_update_after
        Tools::Log.instance.debug 'Callback AFTER_UPDATE'
        if enable && enable_changed?
          create_a_session_in_janus_instance
        elsif !enable && enable_changed?
          destroy_a_session_in_janus_instance
        end
      end

      # Destroy a session in Janus Instance
      def callback_destroy_after
        Tools::Log.instance.debug 'Callback AFTER_DESTROY'
        destroy_a_session_in_janus_instance if enable && session? && thread?
      end

      private

      def create_a_session_in_janus_instance
        info_instance('Create session')
        janus_instance = keepalive_object_new
        set(session: janus_instance.session, thread: janus_instance.thread_id)
      end

      def destroy_a_session_in_janus_instance
        info_instance('Destroy session')
        keepalive_object_thread.send(:response_destroy)
        keepalive_object_thread.kill
        unset(%I[thread session])
      end

      def keepalive_object
        RubyRabbitmqJanus::Janus::Concurrencies::KeepaliveInitializer
      end

      def keepalive_object_new
        keepalive_object.new(instance)
      end

      def keepalive_object_thread
        keepalive_object.thread(thread)
      end

      def info_instance(text)
        Tools::Log.instance.debug "#{text} in Janus Instance [##{instance}]"
      end
    end
  end
end
