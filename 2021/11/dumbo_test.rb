# frozen_string_literal: true

require 'minitest/autorun'
require_relative './dumbo'

# Tests for Day Eleven
class DayElevenTests < MiniTest::Test
  def test_dumbo_part_one
    total = Dumbo.calculate_flashes './11/testdata.txt', 100
    assert total == 1656
    p Dumbo.calculate_flashes './11/data.txt', 100
  end

  def test_dumbo_part_two
    total = Dumbo.when_all_flashing './11/testdata.txt'
    p total
    assert total == 195
    p Dumbo.when_all_flashing './11/data.txt'
  end
end
