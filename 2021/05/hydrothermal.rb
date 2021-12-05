# frozen_string_literal: true

require 'csv'

# Module to calculate hydrothermal puzzle on day five
module Hydrothermal
  def self.load_coords(filename)
    coords = []
    CSV.foreach(filename, 'r', **{ col_sep: ' -> ' }) do |row|
      coords << { x1: row[0].split(',')[0].to_i,
                  y1: row[0].split(',')[1].to_i,
                  x2: row[1].split(',')[0].to_i,
                  y2: row[1].split(',')[1].to_i }
    end
    coords
  end

  def self.filter_hv_lines(coords)
    coords.filter { |coord| coord[:x1] == coord[:x2] || coord[:y1] == coord[:y2] }
  end

  def self.calculate_step(coord1, coord2)
    return 1 if coord1 < coord2

    -1
  end

  def self.plot(map, coords)
    x1 = coords[:x1]
    y1 = coords[:y1]
    x2 = coords[:x2]
    y2 = coords[:y2]
    if x1 == x2 # Vertical line
      ([y1, y2].min..[y1, y2].max).each do |y|
        map[x1][y] = map[x1][y] + 1
      end
    elsif y1 == y2 # Horizontal line
      ([x1, x2].min..[x1, x2].max).each do |x|
        map[x][y1] = map[x][y1] + 1
      end
    else # Diagonal line
      # Diagonal line
      x_step = calculate_step(x1, x2)
      y_step = calculate_step(y1, y2)
      x = x1
      y = y1
      map[x][y] = map[x][y] + 1
      ([y1, y2].max - [y1, y2].min).times do
        x += x_step
        y += y_step
        map[x][y] = map[x][y] + 1
      end
    end
    map
  end

  def self.find_overlaps(coords, hor_ver_only)
    map = Array.new(1000) { Array.new(1000, 0) }
    coords = filter_hv_lines(coords) if hor_ver_only == true
    coords.each do |coord|
      map = plot(map, coord)
    end
    map
  end

  def self.find_points(filename, hor_ver_only)
    coords = load_coords filename
    count = 0
    map = find_overlaps coords, hor_ver_only
    map.each do |row|
      row.each do |cell|
        count += 1 if cell > 1
      end
    end
    count
  end
end
