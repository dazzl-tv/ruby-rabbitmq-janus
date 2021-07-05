# frozen_string_literal: true

# :reek:FeatureEnvy

module RubyRabbitmqJanus
  module Tools
    # Subclass for Config
    #
    # Options about bunny
    #
    # @see RubyRabbitmqJanus::Tools::Config
    module ConfigRabbit
      # @return [String] read configuration fir queue admin
      def admin_pass
        @options['rabbit']['admin_pass'].to_s
      rescue StandardError
        raise RubyRabbitmqJanus::Errors::Tools::AdminPassword
      end

      # @return [Symbol] read configuration for bunny log level
      def log_level_rabbit
        @options['rabbit']['level'].upcase.to_sym || :INFO
      end

      # @return [Hash] Format hash for bunny settings
      def server_settings
        Hash[%w[host port pass user vhost log_level].map do |value|
          key = value.to_sym
          j_value = @options['rabbit'][rabbitmq_conf(value)]

          raise Errors::Tools::Config::Rabbitmq value if j_value.blank?

          [key, j_value]
        end]
      end

      private

      def rabbitmq_conf(value)
        value.eql?('log_level') ? 'level' : value
      end
    end
  end
end
