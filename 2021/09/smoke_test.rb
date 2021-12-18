# frozen_string_literal: true

require 'minitest/autorun'
require_relative './smoke'

# Tests for Day Nine
class DayNineTests < MiniTest::Test
  def test_smoke_part_one
    total = Smoke.scan_map_for_low_points './09/testdata.txt'
    p total
    assert total == 15
    p Smoke.scan_map_for_low_points './09/data.txt'
  end

  def test_smoke_part_two
    total = Smoke.scan_map_for_basins './09/testdata.txt'
    p total
    assert total == 1134
    p Smoke.scan_map_for_basins './09/data.txt'
  end
end
