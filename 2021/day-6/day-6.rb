#!/usr/bin/env ruby

require 'pry'

real_data = File.open('./data.txt').readlines

test_data = ["3,4,3,1,2"]

def process_data(data)
  data[0].split(',').map(&:to_i)
end

# part 1
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
    school.length + babies.length
  else
    lantern_fish([*current, *babies], gen - 1)
  end
end

# part 2
def lantern_fish_hash(school, gen = 1)
  if school.kind_of? Array
    school = school.each_with_object(Hash.new(0)){ |k,h| h[k] += 1 }
  end

  zeros = school[0]

  (0..7).each do |n|
    school[n] = school[n + 1]
  end

  school[6] += zeros
  school[8] = zeros

  if gen == 1
    school.to_a.reduce(0){ |acc, (k,v)| acc += v; acc }
  else
    lantern_fish_hash(school, gen - 1)
  end
end

data = process_data(real_data)

# p lantern_fish(data, 18)
p lantern_fish_hash(data, 256)

