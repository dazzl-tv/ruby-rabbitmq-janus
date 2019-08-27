# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # Subclasse for Config
    #
    # Options about bunny
    #
    # @see RubyRabbitmqJanus::Tools::Config
    module ConfigRabbit
      # @return [String] read configuration fir queue admin
      def admin_pass
        @options['rabbit']['admin_pass'].to_s
      rescue => exception
        p "[admin_pass] #{exception}"
      end

      # @return [Symbol] read configuration for bunny log level
      def log_level_rabbit
        @options['rabbit']['level'].upcase.to_sym || :INFO
      rescue => exception
        p "[log_level_rabbit] #{exception}"
      end

      # @return [Boolean] read configuration for bunny execution
      def tester?
        @options['rabbit']['test'].to_s.match?('true') ? true : false
      rescue => exception
        p "[tester] #{exception}"
      end
    end
  end
end
