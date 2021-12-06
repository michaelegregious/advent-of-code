#!/usr/bin/env ruby

require 'pry'

real_data = File.open('./data.txt').readlines

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

def make_ranges(lines)
  lines.each_with_object([]) do |line, acc|
    start, fin = line.split(' -> ')
    acc << [start.split(',').map(&:to_i), fin.split(',').map(&:to_i)]
  end
end

# part 1
def decipher_vents(ranges)
  count = {co: 0}
  ranges.each_with_object({}) do |coords, field|
    start, fin = coords
    (y1, x1), (y2, x2) = start, fin
    if start[1] == fin[1]
      set_locations(field, [y1, y2], x1, count)
    elsif start[0] == fin[0]
      set_locations(field, [x1, x2], y1, count, true)
    else
      # part 2
      x_range = (x1 < x2 ? (x1..x2) : x1.downto(x2)).to_a
      y_range = (y1 < y2 ? (y1..y2) : y1.downto(y2)).to_a
      set_diagonals(field, x_range, y_range, count)
    end
  end
  count
end

# part 1
def set_locations(field, (x1, x2), y, count, y_mode = false)
  range = (x1..x2).size == 0 ? (x2..x1) : (x1..x2)
  range.each do |x|
    if y_mode
      c = (field[[x,y]] || 0) + 1
      field[[x,y]] = c
      count[:co] += 1 if c == 2
    else
      c = (field[[y,x]] || 0) + 1
      field[[y,x]] = c
      count[:co] += 1 if c == 2
    end
  end
end

# part 2
def set_diagonals(field, y_range, x_range, count)
  y_range.each_with_index do |y, i|
    c = (field[[y, x_range[i]]] || 0) + 1
    field[[y, x_range[i]]] = c
    count[:co] += 1 if c == 2
  end
end

ranges = make_ranges(real_data)
p decipher_vents(ranges)
