# frozen_string_literal: true

require 'minitest/autorun'
require_relative './smoke'

# Tests for Day Eight
class DayNineTests < MiniTest::Test
  def test_smoke_part_one
    # total = Smoke.scan_map './09/testdata.txt'
    # p total
    # assert total == 15
    p Smoke.scan_map './09/data.txt'
  end
end