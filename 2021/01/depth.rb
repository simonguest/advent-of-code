# frozen_string_literal: true

require 'CSV'

# Module to calculate depth puzzle on day one
module Depth
  def self.measure_tuples_from_array(measurements)
    increases = 0
    measurements.each_cons(2) do |a, b|
      increases += 1 if b > a
    end
    increases
  end

  def self.measure_tuples_from_csv(filename)
    csv = CSV.read(filename)
    measure_tuples_from_array(csv.flatten[1..].map(&:to_i))
  end

  def self.measure_triads_from_array(measurements)
    increases = 0
    last = Float::INFINITY
    measurements.each_cons(3)  do |a, b, c|
      increases += 1 if (a + b + c) > last
      last = a + b + c
    end
    increases
  end

  def self.measure_triads_from_csv(filename)
    csv = CSV.read(filename)
    measure_triads_from_array(csv.flatten[1..].map(&:to_i))
  end
end
