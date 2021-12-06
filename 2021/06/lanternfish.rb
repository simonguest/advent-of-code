# frozen_string_literal: true

require 'csv'
require 'benchmark'

# Module to calculate lantern puzzle on day six
module LanternFish
  def self.age_fish(fish)
    aged_fish = fish[0]
    fish = fish.drop(1)
    fish[6] = fish[6] + aged_fish
    fish << aged_fish
    fish
  end

  def self.init_fish
    Array.new(9, 0)
  end

  def self.load_fish(filename)
    fish = init_fish
    input = CSV.read(filename).flatten.map(&:to_i)
    input.each { |i| fish[i] += 1 }
    fish
  end

  def self.run_fish(filename, lifetime)
    fish = load_fish filename
    time = Benchmark.measure do
      lifetime.times do
        fish = age_fish(fish)
      end
    end
    p time.real
    fish.sum
  end
end
