# frozen_string_literal: true

require 'minitest/autorun'
require_relative './segment'

# Tests for Day Eight
class DayEightTests < MiniTest::Test
  def test_segment_part_one
    total = Segment.count_1_4_7_8 './08/testdata.csv'
    assert total == 26
    p Segment.count_1_4_7_8 './08/data.csv'
  end

  def test_segment_part_two
    total = Segment.decipher './08/testdata.csv'
    assert total == 61_229
    p Segment.decipher './08/data.csv'
  end
end
