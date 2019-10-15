# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    # Add method for Janus Instance model
    module Methods
      extend ActiveSupport::Concern

      # Create thread keepalive
      def create_keepalive
        ::Log.info 'Create session'
        janus_instance = keepalive_object_new
        set(session: janus_instance.session, enable: true)
      end

      # Stop thread keepalive
      def stop_keepalive
        ::Log.info 'Destroy session'
        unset(%I[thread thread_adm session])
        set(enable: false)
      end

      # Start Janus instance
      # @since 2.7.1
      def start!
        update(enable: true)
      end

      # Stop Janus instance
      # @since 2.7.1
      def stop!
        update(enable: false)
      end
    end
  end
end
