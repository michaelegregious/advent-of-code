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

def process_data(data)
  data.map{ |row| row.chomp.split('').map(&:to_i) }
end

def risk_number(rows, position = [0, 0], memo = {})
  return memo[position] if memo[position]

  y, x = position; result = 0
  right = x < rows[0].length - 1 ? rows[y][x + 1] : nil
  down = y < rows.length - 1 ? rows[y + 1][x] : nil

  return 0 if [right, down].compact.empty?

  if !right
    result = down + risk_number(rows, [y + 1, x], memo)
    memo[position] = result
    return result
  elsif !down
    result = right + risk_number(rows, [y, x + 1], memo)
    memo[position] = result
    return result
  end

  r = right + risk_number(rows, [y, x + 1], memo)
  d = down + risk_number(rows, [y + 1, x], memo)

  result = d < r ? d : r
  memo[position] = result
  result
end

rows = process_data(real_data)
p risk_number(rows)
