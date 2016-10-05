# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a custom configuration file
    class DefaultRequestGenerator < Rails::Generators::Base
      desc 'Copy base request file sending to janus in application. It\'s necessary if' \
        'you want add your request.'

      def self.source_root
        root_path = File.realpath(File.join(File.dirname(__FILE__), '..', '..', '..'))
        @_rrj_source_root ||= File.join(root_path, 'config')
      end

      def copy_default_request
        directory 'requests', 'config/requests'
      end
    end
  end
end
