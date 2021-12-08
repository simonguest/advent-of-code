# frozen_string_literal: true

require 'csv'
require 'set'

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

  def self.intersection?(pattern, subpattern)
    pattern.chars.to_set.intersection(subpattern.chars.to_set)
  end

  def self.union(pattern, subpattern)
    (pattern.chars.to_set | subpattern.chars.to_set).to_a.join
  end

  def self.determine_digits(pattern)
    digits = Array.new(10, -1)
    # Find the 1 and 7
    pattern.each_with_index do |p, i|
      digits[i] = 1 if p.length == 2
      digits[i] = 4 if p.length == 4
      digits[i] = 7 if p.length == 3
      digits[i] = 8 if p.length == 7
    end

    # Find the 2, 3, and 5
    pattern.each_with_index do |p, i|
      next unless p.length == 5

      digits[i] = 2 if union(p, union(pattern[digits.index(4)], pattern[digits.index(7)])).length == 7
      digits[i] = 3 if intersection?(p, pattern[digits.index(7)]).length == 3
      digits[i] = 5 if union(p, union(pattern[digits.index(4)], pattern[digits.index(7)])).length == 6 &&
                       intersection?(p, pattern[digits.index(7)]).length == 2
    end

    # Find the 0, 6, and 9
    pattern.each_with_index do |p, i|
      next unless p.length == 6

      digits[i] = 6 if intersection?(p, pattern[digits.index(1)]).length == 1
      digits[i] = 9 if intersection?(p, pattern[digits.index(1)]).length == 2 &&
                       intersection?(p, pattern[digits.index(5)]).length == 5
      digits[i] = 0 if intersection?(p, pattern[digits.index(1)]).length == 2 &&
                       intersection?(p, pattern[digits.index(5)]).length == 4
    end
    digits
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

  def self.find_in_pattern(patterns, value)
    patterns.each_with_index do |pattern, index|
      return index if pattern.chars.sort.to_s == value.chars.sort.to_s
    end
    -1
  end

  def self.decipher(filename)
    segments = load_segments filename
    output = 0
    segments.each do |segment|
      digits = determine_digits segment[:patterns]
      result = []
      segment[:values].each do |value|
        result << digits[find_in_pattern(segment[:patterns], value)].to_s
      end
      output += result.join.to_i
    end
    output
  end
end
