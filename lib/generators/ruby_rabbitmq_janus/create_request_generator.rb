# frozen_string_literal: true

# Override String class
class String
  SEPARATOR_LINE = ','
  SEPARATOR_KEY_VALUE = ':'

  # Converting a string with a format special to hash
  def converting_to_hash
    hash = {}
    split(SEPARATOR_LINE).each do |couple_hash|
      hash.merge! HashString.new(couple_hash.split(SEPARATOR_KEY_VALUE)).convert_in_hash
    end
    hash
  end
end

# Create an hash with an array
class HashString
  # Initialize an array
  def initialize(string_array)
    @array = string_array
    @hash = {}
  end

  # Create and return an hash
  def convert_in_hash
    @hash[@array[0]] = test_string_hash
    @hash
  end

  private

  # Test if string is hash
  def test_string_hash
    value.include?('{') ? HashString.new(format_hash_string).convert_in_hash : value
  end

  # Transform string to hash
  def format_hash_string
    @array.drop(1).join(':').sub('{', '').sub('}', '').split(String::SEPARATOR_KEY_VALUE)
  end

  # Return the value for hash object
  def value
    @array[1]
  end
end

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a json request
    class CreateRequestGenerator < Rails::Generators::Base
      desc 'Create an request to json format for RubyRabbitmqJanus.'
      argument :type_name, type: :string, default: ''
      argument :janus_type, type: :string, default: ''
      argument :content, type: :string, default: ''

      # Create an file to json format in folder 'config/request/' to you Rails apps
      def create_request
        create_file file_json, write_json
      end

      private

      # Create a path and name file
      def file_json
        base_file = type_name.empty? ? 'config/requests' : create_folder?(type_name)
        "#{base_file}/#{janus_type}.json"
      end

      # Convert a string to hash and write in json file
      def write_json
        hash = {}
        hash['janus'] = janus_type
        hash.merge!(content.converting_to_hash)
        JSON.pretty_generate(hash)
      end

      # Test if folder is exist and created if necessary
      def create_folder?(folder_name)
        path_folder = "config/requests/#{folder_name}"
        Dir.mkdir path_folder unless File.exist?(path_folder)
        path_folder
      end
    end
  end
end
