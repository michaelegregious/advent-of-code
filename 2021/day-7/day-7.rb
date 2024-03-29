#!/usr/bin/env ruby

real_data = File.open('./data.txt').readlines

test_data = ['16,1,2,0,4,2,7,1,2,14']

def process_data(data)
  data[0].split(',').map(&:to_i)
end

# part 1
def crab_fuel(positions)
  min, max = positions.reduce([Float::INFINITY, -Float::INFINITY]) do |mM, pos|
    mM[0] = pos if pos < mM[0]
    mM[1] = pos if pos > mM[1]
    mM
  end

  (min..max).reduce(Float::INFINITY) do |min_fuel, int|
    fuel = positions.sum{ |pos| (int - pos).abs }
    fuel < min_fuel ? fuel : min_fuel
  end
end

# part 2
def crab_fuel_ramping(positions)
  min, max = positions.reduce([Float::INFINITY, -Float::INFINITY]) do |mM, pos|
    mM[0] = pos if pos < mM[0]
    mM[1] = pos if pos > mM[1]
    mM
  end

  (min..max).reduce(Float::INFINITY) do |min_fuel, int|
    fuel = positions.sum do |pos|
      diff = (int - pos).abs
      diff * (diff + 1) / 2
    end
    fuel < min_fuel ? fuel : min_fuel
  end
end

# data = process_data(test_data)
# p crab_fuel_ramping(data)
