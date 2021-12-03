# frozen_string_literal: true

require 'csv'

# Module to calculate depth puzzle on day two
module Dive
  def self.calculate_position_from_file(filename)
    horizontal_position = 0
    depth = 0
    CSV.foreach(filename, 'r', { col_sep: ' ' }) do |direction|
      case direction[0]
      when 'forward'
        horizontal_position += direction[1].to_i
      when 'up'
        depth -= direction[1].to_i
      when 'down'
        depth += direction[1].to_i
      end
    end
    horizontal_position * depth
  end

  def self.calculate_position_with_aim_from_file(filename)
    horizontal_position = 0
    depth = 0
    aim = 0
    CSV.foreach(filename, 'r', { col_sep: ' ' }) do |direction|
      case direction[0]
      when 'forward'
        horizontal_position += direction[1].to_i
        depth += (aim * direction[1].to_i)
      when 'up'
        aim -= direction[1].to_i
      when 'down'
        aim += direction[1].to_i
      end
    end
    horizontal_position * depth
  end
end
