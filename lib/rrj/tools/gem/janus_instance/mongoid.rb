# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Store instance information for MongoID database
    module JanusInstance
      include Mongoid::Document
      include JanusInstanceConcern

      field :instance, type: Integer
      field :session, type: Integer
      field :enable, type: Boolean

      set_callback(:destroy, :before) { destroy_before_action }
    end
  end
end
