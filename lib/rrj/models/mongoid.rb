# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Store instance information for MongoID database
    class JanusInstance
      include Mongoid::Document
      include RubyRabbitmqJanus::Models::JanusInstanceMethods
      include RubyRabbitmqJanus::Models::JanusInstanceCallback

      field :instance, type: Integer
      field :session, type: Integer
      field :enable, type: Boolean
      field :thread, type: Integer

      set_callback(:create, :after) { callback_create_after }
      set_callback(:update, :after) { callback_update_after }
      set_callback(:destroy, :before) { callback_destroy_before }
    end
  end
end
