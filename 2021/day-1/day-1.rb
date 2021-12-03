#!/usr/bin/env ruby

DATA = File.open('./.day-1-data.txt').readlines

class TwainMarker
  def initialize(data = DATA)
    @data = data
    @depths = process_data
  end

  def process_data(data = @data)
    data ? data.map{ |s| s.chomp.to_i } : []
  end

  # Part 1
  def relative_increases(depths = @depths)
    depths.each_with_index.reduce(0) do |total, (depth, i)|
      prev = i == 0 ? depth : depths[i - 1]
      increase = depth > prev
      total = increase ? total + 1 : total
    end
  end

  # Part 2
  def aggregated_increases(depths = @depths)
    total = 0
    (2..depths.size + 1).each do |i|
      a = depths[i-2..i].sum
      b = depths[i-1..i+1].sum
      total += 1 if (a < b)
    end
    total
  end
end

# TwainMarker.new.aggregated_increases
