# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  module Models
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Store instance information for MongoID database
    class JanusInstance < ::ActiveRecord::Base
      include RubyRabbitmqJanus::Models::Instances
      include RubyRabbitmqJanus::Models::Validations

      self.primary_key = :id

      alias_attribute :instance,        :id
      alias_attribute :title,           :name
      alias_attribute :session_id,      :session

      # Update attributes to document
      #
      # @param attributes [Hash] List of attribute to update with this value
      #
      # @return [Hash] Current model
      def set(attributes)
        update_columns(attributes)
      end

      # Destroy data to column
      #
      # @param attributes [Array] List to attribute to delete in document
      #
      # @return [Hash] Current model
      #
      # rubocop:disable Style/HashTransformValues
      def unset(attributes)
        Hash[attributes.map { |key, _value| [key, nil] }]
      end
      # rubocop:enable Style/HashTransformValues
    end
  end
end
