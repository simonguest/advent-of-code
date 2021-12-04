# frozen_string_literal: true

require 'csv'

# Module to calculate bingo puzzle on day four
module Bingo
  def self.sheet
    Array.new(5) { Array.new(5, 0) }
  end

  def self.load_numbers(filename)
    numbers = []
    CSV.foreach(filename, 'r') do |row|
      numbers = row.map(&:to_i)
    end
    numbers
  end

  def self.load_boards(filename)
    boards = []
    current_board = []
    CSV.foreach(filename, 'r', **{ col_sep: ' ' }) do |row|
      row = row.compact.map(&:to_i) # remove the additional spaces in this file and convert to int
      if row.count.positive?
        current_board << row
        if current_board.count == 5
          boards << current_board
          current_board = []
        end
      end
    end
    boards
  end

  def self.setup_game(filename)
    game = { boards: [], sheets: [] }
    boards = load_boards filename
    boards.each do |board|
      game[:boards] << board
      game[:sheets] << sheet
    end
    game
  end

  def self.check_horizontal(sheet)
    sheet.each do |row|
      return true if row == [1, 1, 1, 1, 1]
    end
    false
  end

  def self.rotate_sheet(sheet)
    rotated = []
    sheet.transpose.each do |r|
      rotated << r.reverse
    end
    rotated
  end

  def self.check_vertical(sheet)
    check_horizontal(rotate_sheet(sheet))
  end

  def self.check_sheet(sheet)
    check_horizontal(sheet) || check_vertical(sheet)
  end

  def self.play_move(game, number)
    updated_sheets = []
    game[:boards].each_with_index do |_, index|
      board = game[:boards][index]
      sheet = game[:sheets][index]
      board.each_with_index do |row, row_index|
        col_index = row.find_index(number)
        sheet[row_index][col_index] = 1 unless col_index.nil?
      end
      updated_sheets << sheet
    end
    game[:sheets] = updated_sheets
    game
  end

  def self.any_winner(game)
    game[:sheets].each_with_index do |sheet, index|
      return index if check_sheet(sheet) == true
    end
    nil
  end

  def self.find_non_winning_sheets(game)
    non_winning_sheets = []
    game[:sheets].each_with_index do |sheet, index|
      non_winning_sheets << index if check_sheet(sheet) == false
    end
    non_winning_sheets
  end

  def self.sum_unmarked_numbers(board, sheet)
    total = 0
    sheet.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        total += board[row_index][cell_index] if cell.zero?
      end
    end
    total
  end

  def self.play_game(numbers_file, boards_file)
    numbers = load_numbers numbers_file
    game = setup_game boards_file
    numbers.each do |number|
      game = play_move(game, number)
      winner = any_winner(game)
      return number * sum_unmarked_numbers(game[:boards][winner], game[:sheets][winner]) unless winner.nil?
    end
    nil
  end

  def self.play_game_last_winner(numbers_file, boards_file)
    non_winning_sheets = []
    numbers = load_numbers numbers_file
    game = setup_game boards_file
    numbers.each do |number|
      game = play_move(game, number)
      if find_non_winning_sheets(game).length.zero?
        return number * sum_unmarked_numbers(game[:boards][non_winning_sheets[0]],
                                             game[:sheets][non_winning_sheets[0]])
      end
      non_winning_sheets = find_non_winning_sheets(game)
    end
    nil
  end
end
