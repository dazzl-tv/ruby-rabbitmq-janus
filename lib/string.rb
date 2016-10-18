# frozen_string_literal: true

# Override String class
class String
  # Converting a string with a format special to hash
  def to_hash(arr_sep = ',', key_sep = ':')
    hash = {}
    split(arr_sep).each do |couple_hash|
      HashString.new(couple_hash.split(key_sep)).convert_in_hash
      # key_value = couple_hash.split(key_sep)
      # hash[key_value[0]] = key_value[1]
    end
    hash
  end
end

# Create an classe for create an hash with an array
class HashString
  # Initialize an array
  def initialize(string_array)
    @array = string_array
  end

  # Create and return an hash
  def convert_in_hash
    hash[@array[0]] = @array[1]
  end
end
