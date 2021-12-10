# frozen_string_literal: true

require 'minitest/autorun'
require_relative './syntax'

# Tests for Day Ten
class DayTenTests < MiniTest::Test
  def test_syntax_part_one
    total = Syntax.scan_code './10/testdata.txt'
    assert total == 26_397
    p Syntax.scan_code './10/data.txt'
  end
end
