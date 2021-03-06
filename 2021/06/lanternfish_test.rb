# frozen_string_literal: true

require 'minitest/autorun'
require_relative './lanternfish'

# Tests for Day Six
class DaySixTests < MiniTest::Test
  def test_fish_part_one
    total = LanternFish.run_fish './06/testdata.csv', 80
    assert total == 5934
    p LanternFish.run_fish './06/data.csv', 80
  end

  def test_fish_part_two
    total = LanternFish.run_fish './06/testdata.csv', 256
    assert total == 26_984_457_539
    p LanternFish.run_fish './06/data.csv', 256
  end
end
