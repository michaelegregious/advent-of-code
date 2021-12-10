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
  data.map(&:to_i)
end

def find_low_pts(rows)
  low_pts = []

  rows.each_with_index do |row, i|
    row.chars.each_with_index do |num, j|
      up = i > 0 ? rows[i - 1][j] : nil
      right = j < row.length - 1 ? row[j + 1] : nil
      left = j == 0 ? nil : row[j - 1]
      down = i < rows.length - 1 ? rows[i + 1][j] : nil

      if [up, down, left, right].compact.all? { |adj| num < adj }
        low_pts << num
      end
    end
  end
  low_pts
end

p find_low_pts(test_data)
