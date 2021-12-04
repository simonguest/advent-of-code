# frozen_string_literal: true

require 'minitest/autorun'
require_relative './dive'

# Tests for Day Two
class DayTwoTests < MiniTest::Test
  def test_dive_part_one
    total = Dive.calculate_position_from_file './02/testdata.csv'
    assert total == 150
    p Dive.calculate_position_from_file './02/data.csv'
  end

  def test_dive_part_two
    total = Dive.calculate_position_with_aim './02/testdata.csv'
    p total
    assert total == 900
    p Dive.calculate_position_with_aim './02/data.csv'
  end
end
