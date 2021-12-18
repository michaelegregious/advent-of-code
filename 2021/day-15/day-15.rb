#!/usr/bin/env ruby

require 'pry'

real_data = File.open('./data.txt').readlines

test_data = [
  "1163751742",
  "1381373672",
  "2136511328",
  "3694931569",
  "7463417111",
  "1319128137",
  "1359912421",
  "3125421639",
  "1293138521",
  "2311944581"
]

# test_data = [
#   "21904",
#   "84611"
# ]

# test_data = [ '12']

def process_data(data)
  data.map{ |row| row.chomp.split('').map(&:to_i) }
end

def risk_number(rows, position = [0, 0])
  y, x = position
  p "position: #{position}"

  right = x < rows[0].length - 1 ? rows[y][x + 1] : nil
  down = y < rows.length - 1 ? rows[y + 1][x] : nil

  # binding.pry
  return 0 if [right, down].compact.empty?
  return down + risk_number(rows, [y + 1, x]) unless right
  return right + risk_number(rows, [y, x + 1]) unless down

  r = right + risk_number(rows, [y, x + 1])
  d = down + risk_number(rows, [y + 1, x])

  d < r ? d : r
end

rows = process_data(test_data)
n = risk_number(rows)

p n
