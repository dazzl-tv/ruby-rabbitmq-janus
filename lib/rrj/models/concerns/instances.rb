# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  module Models
    # Add class methods for JanusInstance model
    module Instances
      extend ActiveSupport::Concern

      # Class methods for Janus Instance model
      module ClassMethods
        # Disable an instance
        def disable(session_id)
          find_by_session(session_id).set(enable: false)
        end

        # Enable an instance
        def enable(session_id)
          find_by_session(session_id).set(enable: true)
        end

        # Clean all instance disabled
        def destroys
          where(enable: false).delete_all
        end

        # Search a record by instance number
        def find_by_instance(instance_search)
          find_by(instance: instance_search)
        end

        # Search a record by session number
        def find_by_session(session_search)
          find_by(session_id: session_search)
        end

        # Get all instance active
        def enabled
          where(enable: true)
        end

        # Get all instance not active
        def disabled
          where(enable: false)
        end
      end
    end
  end
end
