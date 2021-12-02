#!/usr/bin/env ruby

directives = File.open('./data.txt').readlines

# Test_data = [
#   "forward 5",
#   "down 5",
#   "forward 8",
#   "up 3",
#   "down 8",
#   "forward 2",
# ]

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
    # puts "directive: #{directive}"
    # puts "I: #{i}"
    puts "dir: #{dir}"
    puts "units: #{units}"
  end
  x * depth
end

p auto_pilot(directives)

