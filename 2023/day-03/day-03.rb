#!/usr/bin/env ruby

real_data = File.open('./data.txt').readlines

test_data = %w(
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
)

def process_data(data)
  data.map{ |line| line.chomp }
end

# part 1
class GondolaLift
  def initialize(lines)
    @lines = lines
    # @numbers = get_numbers
  end

  # returns a hash of [x, y] => 123 or [x, y] => '#' coordinates for first letter
  def number_and_symbol_coordinates
    @lines.each_with_object({}).with_index do |(line, coordinates), idx|
      mds = line.enum_for(:scan, /(\d+|[^\.\s])/).map { Regexp.last_match }
      mds.each do |md|
        coordinates[[md.begin(0), idx]] = md[0]
      end
    end
  end

end

p test_data
p GondolaLift.new(test_data).number_coordinates

