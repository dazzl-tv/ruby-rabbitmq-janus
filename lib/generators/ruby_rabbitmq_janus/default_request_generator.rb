# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate who copy a default request
    class DefaultRequestGenerator < Rails::Generators::Base
      desc 'Copy base request file sending to janus in application.'

      # Define root path for original file a copied
      source_root File.expand_path('../../../config', __dir__)

      # Copy default request in Rails app
      def copy_default_request
        directory 'requests', 'config/requests'
      end
    end
  end
end
