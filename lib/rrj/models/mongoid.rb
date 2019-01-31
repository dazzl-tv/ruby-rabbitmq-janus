# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Store instance information for MongoID database
    class JanusInstance
      include Mongoid::Document
      include RubyRabbitmqJanus::Models::JanusInstanceCallbacks
      include RubyRabbitmqJanus::Models::JanusInstanceMethods
      include RubyRabbitmqJanus::Models::JanusInstanceValidations

      field :session,     type: Integer, as: :session_id
      field :enable,      type: Boolean
      field :thread,      type: Integer, as: :thread_id
      field :thread_adm,  type: Integer, as: :thread_id_adm

      alias_attribute :instance, :_id

      set_callback(:create,     :after)   { callback_create_after }
      set_callback(:update,     :after)   { callback_update_after }
      set_callback(:destroy,    :after)   { callback_destroy_after }
    end
  end
end
