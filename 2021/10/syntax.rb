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
        return [char]
      end
    end
    []
  end

  def self.scan_code(filename)
    errors = []
    score = 0
    lines = load_code filename
    lines.each do |line|
      errors << scan_line(line)
    end
    errors.flatten.each do |error|
      score += 3 if error == ')'
      score += 57 if error == ']'
      score += 1197 if error == '}'
      score += 25_137 if error == '>'
    end
    score
  end
end
