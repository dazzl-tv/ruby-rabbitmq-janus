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
      end

      # @return [Symbol] read configuration for bunny log level
      def log_level_rabbit
        @options['rabbit']['level'].upcase.to_sym || :INFO
      end

      # @return [Boolean] read configuration for bunny execution
      def tester?
        @options['rabbit']['test'].to_s.match?('true') ? true : false
      end

      # @return [Hash] Format hash for bunny settings
      def server_settings
        Hash[%w[host port pass user vhost log_level].map do |value|
          [
            value.to_sym,
            @options['rabbit'][value.eql?('log_level') ? 'level' : value]
          ]
        end]
      end
    end
  end
end
