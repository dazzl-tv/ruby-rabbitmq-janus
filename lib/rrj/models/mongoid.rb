# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Store instance information for MongoID database
    class JanusInstance
      include Mongoid::Document
      include RubyRabbitmqJanus::Models::Instances
      include RubyRabbitmqJanus::Models::Validations

      field :name,        type: String,  as: :title
      field :session,     type: Integer, as: :session_id
      field :enable,      type: Boolean

      alias_attribute :instance, :_id
    end
  end
end
