# frozen_string_literal: true
require 'minitest/autorun'
require 'rrj'

class RRJTest < Minitest::Test
  def test_say_hello
    assert_equal 'Yopi yop', RRJ::RRJ.new
  end
end
