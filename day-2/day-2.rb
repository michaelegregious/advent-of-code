#!/usr/bin/env ruby

directives = File.open('./data.txt').readlines

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

p auto_pilot(directives)

