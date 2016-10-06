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
        base_file = type_name.empty? ? 'config/requests' : create_folder?(type_name)
        "#{base_file}/#{janus_type}.json"
      end

      def write_json
        hash = {}
        hash['janus'] = janus_type
        hash.merge!(to_hash(content))
        JSON.pretty_generate(hash)
      end

      def to_hash(body, arr_sep = ',', key_sep = ':')
        hash = {}
        body.split(arr_sep).each do |couple_hash|
          key_value = couple_hash.split(key_sep)
          hash[key_value[0]] = test_string_hash(key_value, arr_sep, key_sep)
        end
        hash
      end

      # :reek:DuplicateMethodCall and :reek:FeatureEnvy
      def test_string_hash(value, arr_sep, key_sep)
        if value[1].include? '{'
          to_hash(value.drop(1).join(':').sub('{', '').sub('}', ''), arr_sep, key_sep)
        else
          value[1]
        end
      end

      def create_folder?(folder_name)
        path_folder = "config/requests/#{folder_name}"
        Dir.mkdir path_folder unless File.exist?(path_folder)
        path_folder
      end
    end
  end
end
