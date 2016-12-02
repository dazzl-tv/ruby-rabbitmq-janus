# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate who copy a default request
    class DefaultRequestGenerator < Rails::Generators::Base
      desc 'Copy base request file sending to janus in application.'

      # Define root path for original file a copied
      def self.source_root
        root_path = File.realpath(root_path_gem)
        @_rrj_source_root ||= File.join(root_path, 'config')
      end

      # Copy default request in Rails app
      def copy_default_request
        directory 'requests', 'config/requests'
      end

      private

      # Define a root path
      def root_path_gem
        File.join(File.dirname(__FILE__), '..', '..', '..')
      end
    end
  end
end
