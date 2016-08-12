# frozen_string_literal: true
require 'minitest/autorun'
require 'rrj'

class RJJTest < Minitest::Test
  def test_say_hello
    assert_equal 'Helloooo ...', RJJ.new
  end
end
