# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Store instance information for MongoID database
    class JanusInstance < ::ActiveRecord::Base
      include RubyRabbitmqJanus::Models::JanusInstanceCallbacks
      include RubyRabbitmqJanus::Models::JanusInstanceMethods
      include RubyRabbitmqJanus::Models::JanusInstanceValidations

      after_create      { callback_create_after }
      after_update      { callback_update_after }
      after_destroy     { callback_destroy_after }
    end
  end
end
