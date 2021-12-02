#!/usr/bin/env ruby

directives = File.open('./data.txt').readlines

test_data = [
  "forward 5",
  "down 5",
  "forward 8",
  "up 3",
  "down 8",
  "forward 2",
]

def auto_pilot(directives)
  x = depth = 0
  directives.each do |directive|
    dir, n = directive.split(' ')
    units = Integer(n)
    case dir
    when 'forward' then x += units
    when 'down' then depth += units
    when 'up' then depth -= units
    end
  end
  x * depth
end

# part 2
def auto_pilot_v2(directives)
  x = depth = aim = 0
  directives.each do |directive|
    dir, n = directive.split(' ')
    units = Integer(n)
    case dir
    # when 'forward' then x += units
    when 'forward'
      x += units
      depth += aim * units
    # when 'down' then depth += units
    when 'down' then aim += units
    # when 'up' then depth -= units
    when 'up' then aim -= units
    end
  end
  x * depth
end

p auto_pilot_v2(test_data)

