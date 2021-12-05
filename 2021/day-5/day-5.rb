#!/usr/bin/env ruby

raw_data = File.open('./data.txt').readlines

test_data = [
  "0,9 -> 5,9",
  "8,0 -> 0,8",
  "9,4 -> 3,4",
  "2,2 -> 2,1",
  "7,0 -> 7,4",
  "6,4 -> 2,0",
  "0,9 -> 2,9",
  "3,4 -> 1,4",
  "0,0 -> 8,8",
  "5,5 -> 8,2",
]
# p test_data

def make_ranges(lines)
  lines.each_with_object([]) do |line, acc|
    start, fin = line.split(' -> ')
    acc << [start.split(',').map(&:to_i), fin.split(',').map(&:to_i)]
  end
end



p make_ranges(test_data)
