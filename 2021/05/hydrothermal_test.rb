# frozen_string_literal: true

require 'minitest/autorun'
require_relative './hydrothermal'

# Tests for Day Five
class DayFiveTests < MiniTest::Test
  def test_hydro_part_one
    total = Hydrothermal.find_points './05/testdata.csv', true
    assert total == 5
    p Hydrothermal.find_points './05/data.csv', true
  end

  def test_hydro_part_two
    total = Hydrothermal.find_points './05/testdata.csv', false
    assert total == 12
    p Hydrothermal.find_points './05/data.csv', false
  end
end
