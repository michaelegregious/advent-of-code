#!/usr/bin/env ruby

Parens = File.open('./data.txt').readlines

# part 1
def elevate_the_fat_man(parens)
  floor = 0
  parens.chars.each do |paren|
    p paren
    if paren == '(' then floor += 1
    elsif paren == ')' then floor -= 1
    end
  end
  floor
end

# part 2
def elevate_the_fat_man(parens)
  floor = 0
  parens.chars.each_with_index do |paren, i|
    return i + 1 if floor == -1
    p paren
    if paren == '(' then floor += 1
    elsif paren == ')' then floor -= 1
    end
  end
  nil
end

p elevate_the_fat_man(Parens.join)
