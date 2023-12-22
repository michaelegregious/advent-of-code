#!/usr/bin/env ruby

require 'set'

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
    @coordinates = number_and_symbol_coordinates
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

  def find_part_numbers
    coordinates.each_with_object([]) do |((x, y), number), part_numbers|
      catch :part_number_found do
        next unless is_numeric?(number)

        number.length.times do |num|
          adjacencies(x + num, y).each do |adjacency|
            if coordinates[adjacency] && !is_numeric?(@coordinates[adjacency])
              part_numbers << value.to_i

              throw :part_number_found
            end
          end
        end
      end
    end
  end

  # part 2
  def find_gears
    coordinates.each_with_object([]) do |((x, y), symbol), verified_gears|
      next unless symbol == '*'

      adjacent_part_numbers = Set.new([])

      adjacencies(x, y).each do |adjacency|
        if coordinate_has_number?(adjacency)
          adjacent_part_numbers.add(number_by_coordinates(adjacency))
        end
      end

      verified_gears << adjacent_part_numbers.to_a.inject(:*) if adjacent_part_numbers.length == 2
    end
  end

  private

  def number_by_coordinates(position)
    coordinates[plumped_up_number_coordinates[position]].to_i
  end

  def coordinate_has_number?(position)
    plumped_up_number_coordinates[position] &&
      is_numeric?(coordinates[plumped_up_number_coordinates[position]])
  end

  # returns a hash of [x, y] => [x, y] coordinates for each digit pointing to the coordinate of the first digit
  def plumped_up_number_coordinates
    @plumped_up_number_coordinates ||= coordinates.each_with_object({}) do |((x, y), digit), plumped_up|
      next unless is_numeric?(digit)

      digit.length.times { |idx| plumped_up[[x + idx, y]] = [x, y] }
    end
  end

  def adjacencies(x, y)
    [
      [x, y + 1],
      [x + 1, y + 1],
      [x + 1, y],
      [x + 1, y - 1],
      [x, y - 1],
      [x - 1, y - 1],
      [x - 1, y],
      [x - 1, y + 1],
    ]
  end

  def is_numeric?(obj)
    obj.to_s.match(/\d+/) == nil ? false : true
  end

  attr_reader :coordinates
end

# part 1
# p GondolaLift.new(test_data).find_part_numbers.sum
# p GondolaLift.new(process_data(real_data)).find_part_numbers.sum

# part 2
p GondolaLift.new(test_data).find_gears.sum
p GondolaLift.new(process_data(real_data)).find_gears.sum
