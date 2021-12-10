# frozen_string_literal: true

# Module for Day 10 puzzle
module Syntax
  def self.load_code(filename)
    lines = []
    data = File.open(filename).readlines
    (0..data.length - 1).map do |line|
      lines << data[line].strip
    end
    lines
  end

  def self.scan_line(line)
    stack = []
    opens = '{([<'
    closes = '})]>'
    line.chars.each do |char|
      stack << char if opens.include?(char)
      next unless closes.include?(char)
      if stack.pop != opens[closes.index(char)]
        # Error in code!
        return { error: char }
      end
    end
    { stack: stack }
  end

  def self.scan_code_for_errors(filename)
    results = []
    score = 0
    lines = load_code filename
    lines.each do |line|
      results << scan_line(line)
    end
    results.flatten.each do |result|
      score += 3 if result[:error] == ')'
      score += 57 if result[:error] == ']'
      score += 1197 if result[:error] == '}'
      score += 25_137 if result[:error] == '>'
    end
    score
  end

  def self.reverse_stack(stack)
    opens = '{([<'
    closes = '})]>'
    closing_stack = []
    stack.reverse.each do |symbol|
      closing_stack << closes[opens.index(symbol)]
    end
    closing_stack
  end

  def self.autocomplete_score(stack)
    total = 0
    stack.each do |symbol|
      total *= 5
      total += 2 if symbol == ']'
      total += 1 if symbol == ')'
      total += 3 if symbol == '}'
      total += 4 if symbol == '>'
    end
    total
  end

  def self.find_median(array)
    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end

  def self.scan_code_for_incomplete_lines(filename)
    totals = []
    lines = load_code filename
    lines.each do |line|
      result = scan_line line
      next unless result[:error].nil?

      totals << autocomplete_score(reverse_stack(result[:stack]))
    end
    find_median(totals).to_i
  end
end
