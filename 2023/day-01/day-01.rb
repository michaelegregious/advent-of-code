#!/usr/bin/env ruby

real_data = File.open('./data.txt').readlines

test_1 = %w[
  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
]

test_2 = %w[
  eighten7pj
  63seven78hrdnnsh
  nineight
  abcfoursix6
  6czcdgdmrmzcdcfmsixfkdnbdsplcscqh27
]

$digit_names = %w[
  one
  two
  three
  four
  five
  six
  seven
  eight
  nine
]

$digit_names_regex = $digit_names.join('|')
$digit_regex = /(\d|#{$digit_names_regex})/

def process_data(data)
  data.map{ |line| line.chomp }
end

# part 1
def translate_name(name, digits = $digit_names)
  return name if name.size == 1
  digits.index(name) + 1
end

def part_1(data)
  digits = []
  data.each do |line|
    n = ''
    /^\S*?(\d)\S*/.match(line) { |m| n += $1 }
    /\S*(\d)\S*$/.match(line) { |m| n += $1 }
    digits << n
  end

  digits.map(&:to_i).sum
end

p 'part 1'
p part_1(process_data(real_data))

# part 2
def part_2(data)
  digits = []
  data.each do |line|
    n = ''
    /^\S*?#{$digit_regex}\S*/.match(line) { |m| n += translate_name($1).to_s }
    /\S*#{$digit_regex}\S*$/.match(line) { |m| n += translate_name($1).to_s }
    digits << n
  end

  digits.map(&:to_i).sum
end

p 'part 2'
p part_2(process_data(real_data))
