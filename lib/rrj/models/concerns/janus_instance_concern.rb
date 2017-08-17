# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  module Models
    # Add method for JanusInstance model
    module JanusInstanceConcern
      extend ActiveSupport::Concern

      # Send an action for destroying a session in Janus Gateway instance
      def destroy_before_action
        options = { 'session_id' => session, 'instance' => instance }
        search_initializer(options) do |transaction|
          transaction.publish_message('base::destroy', options)
        end
      end

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

        def enabled
          JanusInstance.where(enable: true)
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
