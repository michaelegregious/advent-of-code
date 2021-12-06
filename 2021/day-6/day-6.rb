#!/usr/bin/env ruby

require 'pry'

real_data = File.open('./data.txt').readlines

test_data = ["3,4,3,1,2"]

def process_data(data)
  data[0].split(',').map(&:to_i)
end

# each fish creates a new fish every 7 days (reset to 6 bc 0 is included)
# one fish might give birth in 2 days, another in 4
# each fish modeled by a single number-- days until it creates another fish
# a new lantern fish needs slightly longer before birthing-- 2 extra days

def lantern_fish(school, gen = 1)
  babies = []
  current = school.map do |fish|
    if fish == 0
      babies << 8
      next 6
    else
      next fish - 1
    end
  end
  if gen == 1
    p [*current, *babies]
    school.length + babies.length
  else
    lantern_fish([*current, *babies], gen - 1)
  end
end

data = process_data(real_data)

p lantern_fish(data, 80)
