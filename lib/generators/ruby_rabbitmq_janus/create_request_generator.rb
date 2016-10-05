# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a custom configuration file
    class CreateRequestGenerator < Rails::Generators::Base
      desc 'Create an request to json format for RubyRabbitmqJanus transaction.'

      def create_request
        puts "Create a super request in config/request/#{file_name}/#{class_name}.json"
      end
    end
  end
end
