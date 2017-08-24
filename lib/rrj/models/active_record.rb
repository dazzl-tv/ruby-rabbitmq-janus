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

      private

      # Update attributes to document
      #
      # @param [Hash] List of attribute to update with this value
      def set(attributes)
        update_attributes!(attributes)
      end
    end
  end
end
