# frozen_string_literal: true

require 'test/unit'
require_relative './depth'

# Tests for Day One
class DayOneTests < Test::Unit::TestCase
  def test_depth_part_one
    increases = Depth.measure_pairs_from_csv './01/testdata.csv'
    assert increases == 7
    p Depth.measure_pairs_from_csv './01/data.csv'
  end

  def test_depth_part_two
    increases = Depth.measure_triples_from_csv './01/testdata.csv'
    assert increases == 5
    p Depth.measure_triples_from_csv './01/data.csv'
  end
end