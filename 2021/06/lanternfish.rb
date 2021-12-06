# frozen_string_literal: true

require 'csv'
require 'benchmark'

# Module to calculate hydrothermal puzzle on day five
module LanternFish

  def self.age_fish(fish)
    updated_fish = []
    fish.each do |fish|
      fish -= 1
      if fish == -1
        fish = 6
        updated_fish << 8
      end
      updated_fish << fish
    end
    updated_fish
  end

  def self.load_fish(filename)
    CSV.read(filename).flatten.map(&:to_i)
  end

  def self.run_fish(filename, lifetime)
    fish = load_fish filename
    time = Benchmark.measure {
      lifetime.times do
        fish = age_fish(fish)
      end
    }
    p time.real
    fish.length
  end

end