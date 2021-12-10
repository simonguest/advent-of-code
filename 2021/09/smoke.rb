# frozen_string_literal: true

require 'csv'

# Module for Day 9 puzzle
module Smoke
  def self.load_map(filename)
    scans = []
    data = File.open(filename).readlines
    (0..data.length - 3).map do |line|
      scan = [data[line].strip, data[line + 1].strip, data[line + 2].strip]
      scans << scan
    end
    { scans: scans, size: [data.length, data[0].length] }
  end

  def self.check_top(scan)
    low_points = []
    # Check top row
    (1..scan[0].length - 2).map do |cursor|
      next unless scan[0][cursor - 1] > scan[0][cursor] &&
                  scan[0][cursor + 1] > scan[0][cursor] &&
                  scan[1][cursor] > scan[0][cursor]

      low_points << scan[0][cursor]
    end
    # Check corners
    if scan[0][1] > scan[0][0] &&
       scan[1][0] > scan[0][0]
      low_points << scan[0][0]
    end
    if scan[0][scan[0].length - 2] > scan[0][scan[0].length - 1] &&
       scan[1][scan[0].length - 2] > scan[0][scan[0].length - 1]
      low_points << scan[0][scan[0].length - 1]
    end
    low_points
  end

  def self.check_row(scan)
    low_points = []
    # Check middle of the row
    (1..scan[1].length - 2).map do |cursor|
      next unless scan[1][cursor - 1] > scan[1][cursor] &&
                  scan[1][cursor + 1] > scan[1][cursor] &&
                  scan[0][cursor] > scan[1][cursor] &&
                  scan[2][cursor] > scan[1][cursor]

      low_points << scan[1][cursor]
    end
    # Check edges
    if scan[1][1] > scan[1][0] &&
       scan[0][0] > scan[1][0] &&
       scan[2][0] > scan[1][0]
      low_points << scan[1][0]
    end
    if scan[1][scan[1].length - 2] > scan[1][scan[1].length - 1] &&
       scan[0][scan[1].length - 1] > scan[1][scan[1].length - 1] &&
       scan[2][scan[1].length - 1] > scan[1][scan[1].length - 1]
      low_points << scan[1][scan[1].length - 1]
    end
    low_points
  end

  def self.check_bottom(scan)
    low_points = []
    # Check top row
    (1..scan[2].length - 2).map do |cursor|
      next unless scan[2][cursor - 1] > scan[2][cursor] &&
                  scan[2][cursor + 1] > scan[2][cursor] &&
                  scan[1][cursor] > scan[2][cursor]

      low_points << scan[2][cursor]
    end
    # Check corners
    if scan[2][1] > scan[2][0] &&
       scan[1][0] > scan[2][0]
      low_points << scan[2][0]
    end
    if scan[2][scan[0].length - 2] > scan[2][scan[0].length - 1] &&
       scan[1][scan[0].length - 2] > scan[2][scan[0].length - 1]
      low_points << scan[2][scan[0].length - 1]
    end
    low_points
  end

  def self.find_low_points(scans)
    low_points = []
    low_points << check_top(scans[0])
    scans.each do |scan|
      low_points << check_row(scan)
    end
    low_points << check_bottom(scans[scans.length - 1])
    low_points
  end

  def self.scan_map_for_low_points(filename)
    map = load_map filename
    low_points = find_low_points(map[:scans])
    low_points.flatten.map(&:to_i).map { |x| x + 1 }.sum
  end
end
