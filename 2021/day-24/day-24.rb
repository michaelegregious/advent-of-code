#!/usr/bin/env ruby

require 'pry'

real_data = File.open('./data.txt').readlines

test_data = [
  '2199943210',
  '3987894921',
  '9856789892',
  '8767896789',
  '9899965678',
]

def process_data(data)
  data.map{ |line| line.chomp.split('').map(&:to_i)}
end

# part 1
