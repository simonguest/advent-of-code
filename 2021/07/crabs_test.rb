# frozen_string_literal: true

require 'minitest/autorun'
require_relative './crabs'

# Tests for Day Seven
class DaySevenTests < MiniTest::Test
  def test_crabs_part_one
    fuel_used = Crabs.find_most_efficient './07/testdata.csv', false
    assert fuel_used == 37
    p Crabs.find_most_efficient './07/data.csv', false
  end

  def test_crabs_part_two
    fuel_used = Crabs.find_most_efficient './07/testdata.csv', true
    assert fuel_used == 168
    p Crabs.find_most_efficient './07/data.csv', true
  end

end
