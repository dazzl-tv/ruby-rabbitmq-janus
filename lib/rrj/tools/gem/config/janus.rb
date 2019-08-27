# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # Subclasse for Config
    #
    # Options about Janus
    #
    # @see RubyRabbitmqJanus::Tools::Config
    module ConfigJanus
      # @return [Integer]
      #   read configuration for janus time to live for keepalive messages
      def time_to_live
        @options['janus']['session']['keepalive'].to_i || 50
      rescue => exception
        p "[time_to_live] #{exception}"
      end

      # @param [Fixnum] index determine what field is readint in array plugins
      #   in configuration file
      # @return [String] read configuration for plugin with index
      def plugin_at(index = 0)
        @options['janus']['plugins'][index].to_s
      rescue => exception
        p "[plugin_at] #{exception}"
      end

      alias ttl time_to_live
    end
  end
end
