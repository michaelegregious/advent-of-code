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
def find_low_pts(rows)
  low_pts = []
  rows.each_with_index do |row, i|
    row.each_with_index do |num, j|
      up = i > 0 ? rows[i - 1][j] : nil
      right = j < row.length - 1 ? row[j + 1] : nil
      left = j == 0 ? nil : row[j - 1]
      down = i < rows.length - 1 ? rows[i + 1][j] : nil

      adjacents = [up, down, left, right].compact

      if adjacents.all? { |adj| num < adj }
        low_pts << num + 1
      end
    end
  end
  low_pts.sum
end

# part 2
def low_pts(rows)
  low_pts = []
  rows.each_with_index do |row, i|
    row.each_with_index do |num, j|
      up = i > 0 ? rows[i - 1][j] : nil
      right = j < row.length - 1 ? row[j + 1] : nil
      left = j == 0 ? nil : row[j - 1]
      down = i < rows.length - 1 ? rows[i + 1][j] : nil

      adjacents = [up, down, left, right].compact

      if adjacents.all? { |adj| num < adj }
        low_pts << [i, j]
      end
    end
  end
  low_pts
end

def basin(low_pt, rows)
  x, y = low_pt
  basin_pts = []
  adjacents = [
    [x - 1, y],
    [x, y + 1],
    [x + 1, y],
    [x, y - 1],
  ]

  adjacents.each do |(i, j)|
    if has_n?([i, j], rows) && rows[i][j] > rows[x][y] && rows[i][j] < 9
      basin([i, j], rows).each { |pr| basin_pts << pr }
    end
  end

  return basin_pts.unshift(low_pt)
end

def has_n?((i, j), rows)
  return false if !i&.between?(0, rows.length - 1) || !j&.between?(0, rows[0].length - 1)
  return true
end

def largest_basin(rows)
  low_pts(rows).reduce([]) do |sizes, low_pt|
    sizes << basin(low_pt, rows).uniq.size
  end.sort.last(3).reduce(:*)
end

data = process_data(real_data)

p largest_basin(data)

