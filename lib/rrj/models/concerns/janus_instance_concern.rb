# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    module JanusInstanceConcern
      extend ActiveSupport::Concern

      def destroy_before_action
        options = { 'session_id' => intance.session }
        Janus::Messages::Standard.new('base::destroy', options)
      end

      module ClassMethods
        # Disable an instance
        def disable(session_id)
          Tools::Log.instance.info "Disable instance with session : #{session_id}"
          JanusInstance.find_by(session: session_id).set(enable: false)
        end

        # Delete all instance disabled
        def destroys
          JanusInstance.where(enable: false).delete_all
        end

        def find_by_instance(instance_search)
          JanusInstance.find_by(instance: instance_search)
        rescue
          false
        end
      end
    end
  end
end
