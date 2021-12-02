#!/usr/bin/env ruby

DATA = File.open('./.day-1-data.txt').readlines

class TwainMarker
  def initialize(data = DATA)
    @data = data
  end

  def get_depths(data = @data)
    data ? data.map{ |s| s.chomp.to_i } : []
  end

  # Part 1
  def relative_increases
    get_depths.each_with_index.reduce(0) do |total, (depth, i)|
      prev = i == 0 ? depth : depths[i - 1]
      increase = depth > prev
      total = increase ? total + 1 : total
    end
  end

  # Part 2 (works with both)
  def aggregated_increases(aggregate = 3)
    depths = get_depths
    total = 0
    (2..depths.size).each do |i|
      break if i + 1 == depths.size
      a = depths[i] + depths[i - 1] + depths[i - 2]
      b = depths[i + 1] + depths[i] + depths[i - 1]
      p "A: #{a}"
      p "B: #{b}"
      p "I: #{i}"
      total += 1 if (a < b)
      # total += 1
    end
    # p "depth size", depths.size
    # p "triplets", la
    total
  end

end

# part 2 - simpler
# Depths = TwainMarker.new.depths

test_data = %w(
  199
  200
  208
  210
  200
  207
  240
  269
  260
  263
)

p TwainMarker.new(test_data).aggregated_increases
