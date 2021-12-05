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
      x1, x2 = [start[0], fin[0]]
      y = start[1]
      range = (x1..x2).size == 0 ? (x2..x1) : (x1..x2)
      range.each do |x|
        field[y] = field[y] || []
        field[y][x] = (field[y][x] || 0) + 1
      end
    elsif start[0] == fin[0]
      y1, y2 = [start[1], fin[1]]
      x = start[0]
      range = (y1..y2).size == 0 ? (y2..y1) : (y1..y2)
      range.each do |y|
        field[y] ||= []
        field[y][x] = (field[y][x] || 0) + 1
      end
    end
  end
end

def set_locations(ranges, sub_range, y, orientation = 'x')
  # ranges.map!{ |row| row || [] } unless orientation == 'x'
end



ranges = make_ranges(test_data)
arr = decipher_vents(ranges)
arr.each { |l| p l }
