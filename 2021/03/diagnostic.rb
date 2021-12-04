# frozen_string_literal: true

require 'csv'

# Module to calculate diagnostic puzzle on day three
module Diagnostic
  def self.rotate_array(array)
    rotated = []
    array.transpose.each do |r|
      rotated << r.reverse
    end
    rotated
  end

  def self.find_msb(bits, default)
    return default if bits.count('0') == bits.count('1')
    return 0 if bits.count('0') > bits.count('1')

    1
  end

  def self.find_lsb(bits, default)
    return default if bits.count('0') == bits.count('1')
    return 1 if bits.count('0') > bits.count('1')

    0
  end

  def self.load_array(filename)
    bits = []
    CSV.foreach(filename, 'r', **{ col_sep: ' ' }) do |diagnostic|
      bits << diagnostic[0].chars
    end
    bits
  end

  def self.diagnostic_from_file(filename)
    bits = load_array(filename)
    msb = []
    lsb = []
    rotate_array(bits).each do |row|
      msb << find_msb(row, 1)
      lsb << find_lsb(row, 0)
    end
    msb.join.to_i(2) * lsb.join.to_i(2)
  end

  def self.oxygen_from_file(filename)
    filtered_array = load_array(filename)
    rotate_array(filtered_array).each_with_index do |_, index|
      if filtered_array.length > 1
        filtered_array = filtered_array.select { |r| r[index].to_i == find_msb(rotate_array(filtered_array)[index], 1) }
      end
    end
    filtered_array.join.to_i(2)
  end

  def self.co2_from_file(filename)
    filtered_array = load_array(filename)
    rotate_array(filtered_array).each_with_index do |_, index|
      if filtered_array.length > 1
        filtered_array = filtered_array.select { |r| r[index].to_i == find_lsb(rotate_array(filtered_array)[index], 0) }
      end
    end
    filtered_array.join.to_i(2)
  end

  def self.lifesupport_from_file(filename)
    oxygen = oxygen_from_file(filename)
    co2 = co2_from_file(filename)
    oxygen * co2
  end
end
