# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Store instance information
    class JanusInstance
      include Mongoid::Document

      field :instance, type: Integer
      field :session, type: Integer
      field :enable, type: Boolean

      set_callback(:destroy, :before) do
        options = { 'session_id' => intance.session }
        Janus::Messages::Standard.new('base::destroy', options)
      end

      # Disable an instance
      def self.disable(session_id)
        Tools::Log.instance.info "Disable instance with session : #{session_id}"
        JanusInstance.find_by(session: session_id).set(enable: false)
      end

      # Delete all instance disabled
      def self.destroys
        JanusInstance.where(enable: false).delete_all
      end

      def self.find_by_instance(instance_search)
        JanusInstance.find_by(instance: instance_search)
      rescue
        false
      end
    end
  end
end
