# frozen_string_literal: true

require 'test/unit'
require_relative './dive'

# Tests for Day Two
class DayTwoTests < Test::Unit::TestCase
  def test_dive_part_one
    total = Dive.calculate_position_from_file './02/testdata.csv'
    assert total == 150
    p Dive.calculate_position_from_file './02/data.csv'
  end

  def test_dive_part_two
    total = Dive.calculate_position_with_aim_from_file './02/testdata.csv'
    p total
    assert total == 900
    p Dive.calculate_position_with_aim_from_file './02/data.csv'
  end
end
