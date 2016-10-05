# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a custom configuration file
    class CreateRequestGenerator < Rails::Generators::Base
      desc 'Create an request to json format for RubyRabbitmqJanus transaction.'
      argument :type_name, type: :string, default: ''
      argument :janus_type, type: :string, default: ''
      argument :content, type: :string, default: ''

      def create_request
        File.open(file_json, 'w') do |file|
          file.write(write_json)
        end
      end

      private

      def file_json
        base_file = 'config/requests'
        base_file = "#{base_file}/#{type_name}" unless type_name.empty?
        "#{base_file}/#{janus_type}.json"
      end

      def write_json
        hash = {}
        hash['janus'] = janus_type
        hash['body'] = content
        JSON.pretty_generate(hash)
      end
    end
  end
end
