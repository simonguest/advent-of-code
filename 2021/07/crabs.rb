# frozen_string_literal: true

require 'csv'
require 'benchmark'

# Module to calculate crab puzzle on day seven
module Crabs
  def self.calculate_fuel(crabs, position)
    fuel_required = 0
    crabs.each { |crab| fuel_required += (position - crab).abs }
    fuel_required
  end

  def self.calculate_fuel_increasing(crabs, position)
    fuel_required = 0
    crabs.each { |crab| fuel_required += ((position - crab).abs * ((position - crab).abs + 1)) / 2 }
    fuel_required
  end

  def self.load_crabs(filename)
    CSV.read(filename).flatten.map(&:to_i)
  end

  def self.find_most_efficient(filename, increasing)
    least_fuel = Float::INFINITY
    crabs = load_crabs filename
    (1..crabs.max).each do |position|
      fuel_required = if increasing == true
                        calculate_fuel_increasing(crabs, position)
                      else
                        calculate_fuel(crabs, position)
                      end
      least_fuel = fuel_required if fuel_required < least_fuel
    end
    least_fuel
  end
end
