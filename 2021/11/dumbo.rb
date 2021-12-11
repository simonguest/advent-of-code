# frozen_string_literal: true

# Module for Day 11 puzzle
module Dumbo
  @flashes = 0

  def self.process_flashes(map, flashes)
    @flashes += flashes.length
    flashes.each do |flash|
      adjacent_cells = find_adjacent_cells(map, flash)
      result = increment_cells(map, adjacent_cells)
      map = process_flashes(result[:map], result[:new_flashes]) if result[:new_flashes].length.positive?
    end
    map
  end

  def self.calculate_flashes(filename, steps)
    step = 0
    @flashes = 0
    map = load_map(filename)
    while step < steps
      map = increment_map(map)
      map = process_flashes(map, find_flashes(map))
      map = reset_flashes(map)
      step += 1
    end
    @flashes
  end

  def self.when_all_flashing(filename)
    step = 0
    map = load_map(filename)
    while step < 1000
      map = increment_map(map)
      map = process_flashes(map, find_flashes(map))
      map = reset_flashes(map)
      step += 1
      return step if all_flashing?(map)
    end
    -1
  end

  def self.all_flashing?(map)
    map.count(Array.new(map[0].length, 0)) == map.length
  end

  def self.load_map(filename)
    map = []
    data = File.open(filename).readlines
    (0..data.length - 1).map do |line|
      map << data[line].strip.chars.map(&:to_i)
    end
    map
  end

  def self.increment_map(map)
    map.map do |row|
      row.map do |cell|
        cell + 1
      end
    end
  end

  def self.find_flashes(map)
    coords = []
    map.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        coords << { x: row_index, y: cell_index } if cell == 10
      end
    end
    coords
  end

  def self.find_adjacent_cells(map, coords)
    x = coords[:x]
    y = coords[:y]
    width = map[0].length - 1
    height = map.length - 1
    adjacent_cells = [{ x: x, y: y - 1 }, { x: x, y: y + 1 }, { x: x - 1, y: y }, { x: x + 1, y: y },
                      { x: x - 1, y: y - 1 }, { x: x - 1, y: y + 1 }, { x: x + 1, y: y - 1 }, { x: x + 1, y: y + 1 }]
    # Remove out of bounds cells
    adjacent_cells.filter do |cell|
      (cell[:x] >= 0 && cell[:x] <= height) && (cell[:y] >= 0 && cell[:y] <= width)
    end
  end

  def self.increment_cells(map, array_of_coords)
    new_flashes = []
    array_of_coords.each do |coord|
      map[coord[:x]][coord[:y]] = map[coord[:x]][coord[:y]] + 1
      new_flashes << { x: coord[:x], y: coord[:y] } if map[coord[:x]][coord[:y]] == 10
    end
    { map: map, new_flashes: new_flashes }
  end

  def self.reset_flashes(map)
    new_map = []
    map.each do |row|
      new_map << row.map { |cell| cell > 9 ? 0 : cell }
    end
    new_map
  end
end
