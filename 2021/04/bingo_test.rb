# frozen_string_literal: true

require 'minitest/autorun'
require_relative './bingo'

# Tests for Day Four
class DayFourTests < MiniTest::Test
  def test_bingo_part_one
    total = Bingo.play_game('./04/testnumbers.csv', './04/testboards.csv')
    assert total == 4512
    p Bingo.play_game('./04/numbers.csv', './04/boards.csv')
  end

  def test_bing_part_two
    total = Bingo.play_game_last_winner('./04/testnumbers.csv', './04/testboards.csv')
    assert total == 1924
    p Bingo.play_game_last_winner('./04/numbers.csv', './04/boards.csv')
  end
end
