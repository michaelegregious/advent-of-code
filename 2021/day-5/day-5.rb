#!/usr/bin/env ruby

puzzle_input = File.open('./data.txt').readlines

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

def decipher_vents(ranges)
  ranges.each_with_object([]) do |coords, field|
    start, fin = coords
    if start[1] == fin[1]
      set_locations(field, [start[0], fin[0]], start[1])
    elsif start[0] == fin[0]
      set_locations(field, [start[1], fin[1]], start[0], true)
    end
  end
end



def set_locations(field, (x1, x2), y, y_mode = false)
  x = y if y_mode
  range = (x1..x2).size == 0 ? (x2..x1) : (x1..x2)
  if y_mode
    range.each_with_index do |y|
      field[y] ||= []
      field[y][x] = (field[y][x] || 0) + 1
    end
  else
    range.each_with_index do |x|
      field[y] ||= []
      field[y][x] = (field[y][x] || 0) + 1
    end
  end
end



ranges = make_ranges(test_data)
arr = decipher_vents(ranges)
arr.each { |l| p l }