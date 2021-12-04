# frozen_string_literal: true

require 'minitest/autorun'
require_relative './diagnostic'

# Tests for Day Three
class DayThreeTests < MiniTest::Test
  def test_diagnostic_part_one
    total = Diagnostic.diagnostic_from_file './03/testdata.csv'
    assert total == 198
    p Diagnostic.diagnostic_from_file './03/data.csv'
  end

  def test_diagnostic_part_two
    total = Diagnostic.lifesupport_from_file './03/testdata.csv'
    assert total == 230
    p Diagnostic.lifesupport_from_file './03/data.csv'
  end
end
