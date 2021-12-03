# frozen_string_literal: true

require 'csv'

# Module to calculate depth puzzle on day one
module Depth
  def self.measure_pairs_from_array(measurements)
    increases = 0
    measurements.each_cons(2) do |a, b|
      increases += 1 if b > a
    end
    increases
  end

  def self.measure_pairs_from_csv(filename)
    data = CSV.read(filename)
    measure_pairs_from_array(data.flatten[1..].map(&:to_i))
  end

  def self.measure_triples_from_array(measurements)
    increases = 0
    last = Float::INFINITY
    measurements.each_cons(3)  do |a, b, c|
      increases += 1 if (a + b + c) > last
      last = a + b + c
    end
    increases
  end

  def self.measure_triples_from_csv(filename)
    data = CSV.read(filename)
    measure_triples_from_array(data.flatten[1..].map(&:to_i))
  end
end
