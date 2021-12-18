# frozen_string_literal: true

require 'csv'

# Module for Day 9 puzzle
module Smoke
  def self.find_adjacent_cells(map, coords)
    x = coords[:x]
    y = coords[:y]
    width = map[0].length - 1
    height = map.length - 1
    adjacent_cells = [{ x: x, y: y - 1 }, { x: x, y: y + 1 }, { x: x - 1, y: y }, { x: x + 1, y: y }]
    # Remove out of bounds cells
    adjacent_cells.filter do |cell|
      (cell[:x] >= 0 && cell[:x] <= height) && (cell[:y] >= 0 && cell[:y] <= width)
    end
  end

  def self.low_point?(map, coords)
    lower = true
    adjacent_cells = find_adjacent_cells(map, coords)
    adjacent_cells.each do |cell|
      lower = false if map[coords[:x]][coords[:y]] >= map[cell[:x]][cell[:y]]
    end
    lower
  end

  def self.load_map(filename)
    map = []
    data = File.open(filename).readlines
    (0..data.length - 1).map do |line|
      map << data[line].strip.chars.map(&:to_i)
    end
    map
  end

  def self.scan_map_for_low_points(filename)
    low_points = []
    map = load_map filename
    map.each_with_index do |row, row_index|
      row.each_with_index do |_, cell_index|
        if low_point?(map, { x: row_index, y: cell_index })
          low_points << { x: row_index, y: cell_index, value: map[row_index][cell_index] }
        end
      end
    end
    low_points.map { |p| p[:value] + 1 }.sum
  end
end
