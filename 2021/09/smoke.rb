# frozen_string_literal: true

require 'csv'

# Module for Day 9 puzzle
module Smoke
  @@map_size = [0,0]

  def self.load_map(filename)
    scans = []
    data = File.open(filename).readlines
    @@map_size = [data.length, data[0].length]
    (0..data.length-3).map do |line|
      scan = [data[line], data[line+1], data[line+2]]
      scans << scan
    end
    scans
  end

  def self.check_row(scan)
    low_points = []
    # Check middle of the row
    (1..scan[1].length-2).map do |cursor|
      if scan[1][cursor-1] > scan[1][cursor] &&
         scan[1][cursor+1] > scan[1][cursor] &&
         scan[0][cursor] > scan[1][cursor] &&
         scan[2][cursor] > scan[1][cursor] then low_points << scan[1][cursor]
      end
    end
    # Check edges
    if scan[1][1] > scan[1][0] &&
      scan[0][0] > scan[1][0] &&
      scan[2][0] > scan[1][0] then low_points << scan[1][0]
    end
    if scan[1][scan[1].length - 3] > scan[1][scan[1].length - 2] &&
      scan[0][scan[1].length - 2] > scan[1][scan[1].length - 2] &&
      scan[2][scan[1].length - 2] > scan[1][scan[1].length - 2] then low_points << scan[1][scan[1].length - 2]
    end
    low_points
  end

  def self.check_top(scan)
    low_points = []
    # Check top row
    (1..scan[0].length - 2).map do |cursor|
      if scan[0][cursor-1] > scan[0][cursor] &&
        scan[0][cursor+1] > scan[0][cursor] &&
        scan[1][cursor] > scan[0][cursor] then low_points << scan[0][cursor]
      end
    end
    # Check corners
    if scan[0][1] > scan[0][0] &&
      scan[1][0] > scan[0][0] then low_points << scan[0][0]
    end
    if scan[0][scan[0].length - 3] > scan[0][scan[0].length - 2] &&
      scan[1][scan[0].length - 3] > scan[0][scan[0].length - 2] then low_points << scan[0][scan[0].length - 2]
    end
    low_points
  end

  def self.check_bottom(scan)
    low_points = []
    # Check top row
    (1..scan[2].length - 2).map do |cursor|
      if scan[2][cursor-1] > scan[2][cursor] &&
        scan[2][cursor+1] > scan[2][cursor] &&
        scan[1][cursor] > scan[2][cursor] then low_points << scan[2][cursor]
      end
    end
    # Check corners
    if scan[2][1] > scan[2][0] &&
      scan[1][0] > scan[2][0] then low_points << scan[2][0]
    end
    if scan[2][scan[0].length - 3] > scan[2][scan[0].length - 2] &&
      scan[1][scan[0].length - 3] > scan[2][scan[0].length - 2] then low_points << scan[2][scan[0].length - 2]
    end
    low_points
  end

  def self.scan_map(filename)
    low_points = []
    scans = load_map filename
    low_points << check_top(scans[0])
    scans.each do |scan|
      low_points << check_row(scan)
    end
    low_points << check_bottom(scans[scans.length - 1])
    return low_points.flatten.map(&:to_i).map{|x|x+1}.sum
  end
end