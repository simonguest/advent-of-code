# frozen_string_literal: true

require 'csv'

# Module to solve Segment puzzle on Day 8
module Segment
  def self.digits
    [6, 2, 5, 5, 4, 5, 6, 3, 7, 6]
  end

  def self.load_segments(filename)
    segments = []
    CSV.foreach(filename, 'r', **{ col_sep: ' | ' }) do |row|
      segments << { patterns: row[0].split, values: row[1].split }
    end
    segments
  end

  def self.count_1_4_7_8(filename)
    total = 0
    segments = load_segments filename
    segments.each do |segment|
      segment[:values].each do |value|
        total += 1 if value.length == digits[1]
        total += 1 if value.length == digits[4]
        total += 1 if value.length == digits[7]
        total += 1 if value.length == digits[8]
      end
    end
    total
  end
end
