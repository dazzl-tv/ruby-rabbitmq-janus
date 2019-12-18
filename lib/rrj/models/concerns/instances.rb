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
          JanusInstance.find_by(session: session_id).set(enable: false)
        end

        # Clean all instance disabled
        def destroys
          JanusInstance.where(enable: false).delete_all
        end

        # Search a record by instance number
        def find_by_instance(instance_search)
          JanusInstance.find_by(instance: instance_search)
        end

        # Search a record by session number
        def find_by_session(session_search)
          JanusInstance.find_by(session: session_search)
        end

        # Get all instance active
        def enabled
          JanusInstance.where(enable: true)
        end

        # Get all instance not active
        def disabled
          JanusInstance.where(enable: false)
        end
      end
    end
  end
end
