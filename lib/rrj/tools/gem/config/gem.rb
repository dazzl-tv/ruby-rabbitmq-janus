# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  module Tools
    # Subclass for Config
    #
    # Options about Gem
    #
    # @see RubyRabbitmqJanus::Tools::Config
    module ConfigGem
      # @return [Boolean] Read option file for a janus cluster section
      def cluster
        @options['gem']['cluster']['enabled'].to_s.match?('true') || false
      end

      # @return [Symbol] read configuration for log level used in this gem
      def log_level
        @options['gem']['log']['level'].upcase.to_sym || :INFO
      end

      # @return [Symbol] Read level to log
      def log_type
        @options['gem']['log']['type'].downcase.to_sym || :stdout
      end

      # @return [String] read configuration for log option
      def log_option
        option = @options['gem']['log']['option']
        option.empty? ? nil : option
      end

      # @return [String] Get path to classes in project calling this gem.
      def listener_path
        @options['gem']['listener']['public'].to_s ||
          'app/ruby_rabbitmq_janus/action_events'
      end

      # @return [String] Get path to classes in project calling this gem.
      def listener_admin_path
        @options['gem']['listener']['admin'].to_s ||
          'app/ruby_rabbitmq_janus/action_admin_events'
      end

      # @return [String] Environment gem executed.
      def environment
        @options['gem']['environment'].to_s || 'development'
      end

      # @return [String] Get orm used (mongoid or active_record)
      def object_relational_mapping
        @options['gem']['orm'].to_s || 'mongoid'
      end

      # @return [String] Get program name or GEM_NAME
      def program_name
        ENV['PROGRAM_NAME'] || RubyRabbitmqJanus::GEM_NAME
      end

      # @return [String] Get path for json files contains a Janus response
      def rspec_response
        @options['gem']['response_path'] || 'spec/responses'
      end

      # @return [Integer] get number of thread created for listen public queues
      def public_queue_process
        @options['gem']['process'] || 1
      end

      alias env environment
      alias orm object_relational_mapping
      alias pg program_name
    end
  end
end
