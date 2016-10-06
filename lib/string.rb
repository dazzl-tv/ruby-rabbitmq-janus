# frozen_string_literal: true

# Override String class for converting a string to hash
# :reek:FeatureEnvy
class String
  def to_hash(arr_sep = ',', key_sep = ':')
    hash = {}
    split(arr_sep).each do |couple_hash|
      key_value = couple_hash.split(key_sep)
      hash[key_value[0]] = key_value[1]
    end
    hash
  end
end
