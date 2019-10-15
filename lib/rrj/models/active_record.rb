# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  module Models
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Store instance information for MongoID database
    class JanusInstance < ::ActiveRecord::Base
      include RubyRabbitmqJanus::Models::Instances
      include RubyRabbitmqJanus::Models::Methods
      include RubyRabbitmqJanus::Models::Callbacks
      include RubyRabbitmqJanus::Models::Validations

      self.primary_key = :id

      alias_attribute :instance,        :id
      alias_attribute :name,            :title
      alias_attribute :session_id,      :session
      alias_attribute :thread_id,       :thread
      alias_attribute :thread_id_adm,   :thread_adm

      after_create      { callback_create_after }
      after_update      { callback_update_after }
      after_destroy     { callback_destroy_after }

      # Update attributes to document
      #
      # @param [Hash] List of attribute to update with this value
      def set(attributes)
        update_columns(attributes)
      end

      # Destroy data to column
      #
      # @param [Array] List to attribute to delete in document
      def unset(attributes)
        Hash[attributes.map { |key, _value| [key, nil] }]
      end
    end
  end
end
