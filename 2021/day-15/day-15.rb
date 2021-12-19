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

# part 1
def risk_number(rows, pos = [0, 0], memo = {})
  return memo[pos] if memo[pos]

  y, x = pos; result = 0
  right = x < rows[0].length - 1 ? rows[y][x + 1] : nil
  down = y < rows.length - 1 ? rows[y + 1][x] : nil

  return 0 if [right, down].compact.empty?

  if !right
    result = down + risk_number(rows, [y + 1, x], memo)
    memo[pos] = result
    return result
  elsif !down
    result = right + risk_number(rows, [y, x + 1], memo)
    memo[pos] = result
    return result
  end

  r = right + risk_number(rows, [y, x + 1], memo)
  d = down + risk_number(rows, [y + 1, x], memo)

  result = d < r ? d : r
  memo[pos] = result
  result
end

# part 2
def risk_number_x(rows, pos = [0, 0], memo = {})
  return memo[pos] if memo[pos]

  y, x = pos; result = 0
  right, down = calc_heights(rows, pos)

  return 0 if [right, down].compact.empty?

  if !right
    result = down + risk_number_x(rows, [y + 1, x], memo)
    memo[pos] = result
    return result
  elsif !down
    result = right + risk_number_x(rows, [y, x + 1], memo)
    memo[pos] = result
    return result
  end

  r = right + risk_number_x(rows, [y, x + 1], memo)
  d = down + risk_number_x(rows, [y + 1, x], memo)

  # p memo
  result = d < r ? d : r
  memo[pos] = result
  result
end

def calc_heights(rows, (y, x))
  len = rows.length; wid = rows[0].length
  total_len = len * 5; total_wid = wid * 5

  right = if x < total_wid - 1
    add = (x + 1) / wid + y / len
    n = rows[y % len][(x + 1) % wid]
    n + add > 9 ? n + add - 9 : n + add
  else
    nil
  end

  down = if y < total_len - 1
    add = x / wid + (y + 1) / len
    n = rows[(y + 1) % len][x % wid]
    n + add > 9 ? n + add - 9 : n + add
  else
    nil
  end
  # p "pos: #{[y, x]}"
  # p "right, down: #{[right, down]}"
  [right, down]
end

rows = process_data(test_data)
p risk_number_x(rows)
