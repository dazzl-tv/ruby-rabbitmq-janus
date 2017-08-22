# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  module Models
    # Add method for JanusInstance model
    module JanusInstanceMethods
      extend ActiveSupport::Concern

      # Class methods for JanusInstance model
      module ClassMethods
        # Disable an instance
        def disable(session_id)
          JanusInstance.find_by(session: session_id).set(enable: false)
        end

        # Delete all instance disabled
        def destroys
          JanusInstance.where(enable: false).delete_all
        end

        # Search a record by instance number
        def find_by_instance(instance_search)
          JanusInstance.find_by(instance: instance_search)
        rescue
          false
        end

        # Search a record by session number
        def find_by_session(session_search)
          JanusInstance.find_by(session: session_search)
        rescue
          nil
        end

        # Get all instance active
        def enabled
          JanusInstance.where(enable: true)
        end

        # Get instance associated to thread ID
        def find_by_thread(janus_thread)
          JanusInstance.find_by(thread: janus_thread)
        end

        # Save basic information for thread connected to Janus Instance
        def start(thread_id, session_id)
          set(thread: thread_id, session: session_id)
        end

        # Reset document. Delete value for thread and session
        def reset(thread)
          JanusInstance.find_by_thread(thread).unset(%I[thread session])
        end
      end

      private

      def search_initializer(options)
        if File.basename($PROGRAM_NAME) == 'rake'
          ::RRJ.start_transaction(options) do |transaction|
            yield(transaction)
          end
        else
          ::RRJ.start_transaction(true, options) do |transaction|
            yield(transaction)
          end
        end
      end
    end
  end
end
