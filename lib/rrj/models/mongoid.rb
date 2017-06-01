# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Store instance information for MongoID database
    class JanusInstance
      include Mongoid::Document
      include RubyRabbitmqJanus::Models::JanusInstanceConcern

      field :instance, type: Integer
      field :session, type: Integer
      field :enable, type: Boolean

      set_callback(:destroy, :before) { destroy_before_action }
    end
  end
end
