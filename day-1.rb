#!/usr/bin/env ruby

DATA = File.open('./.day-1-data.txt').readlines

class TwainMarker
  def initialize(data = DATA)
    @data = data
  end

  def depths
    @data ? @data.map{ |s| s.chomp.to_i } : []
  end

  def relative_increases
    depths.each_with_index.reduce(0) do |total, (depth, i)|
      prev = i == 0 ? depth : depths[i - 1]
      increase = depth > prev
      total = increase ? total + 1 : total
    end
  end
end

# p TwainMarker.new.relative_increases
