#!/usr/bin/env ruby

real_data = File.open('./data.txt').readlines

test_1 = %w[
  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
]

test_2 = %w[
  63seven78hrdnnsh
  eightenpj
  abcfoursix6
  6czcdgdmrmzcdcfmsixfkdnbdsplcscqh27
]

digit_names = %w[
  one
  two
  three
  four
  five
  six
  seven
  eight
  nine
  ten
]

digit_names_regex = /#{digit_names.join('|')}/
digit_regex = /([\d]|one|two|three|four|five|six|seven|eight|nine|ten)/

p digit_names_regex


def process_data(data)
  data.map{ |line| line.chomp }
end

# part 1
def translate_name(name, digits = digit_names)
  return name if name.size == 1
  digits.index(name) + 1
end

def part_1(data)
  digits = []
  data.each do |line|
    n = ''
    /^\S*?(\d|one|two|three|four|five|six|seven|eight|nine|ten)\S*/.match(line) { |m| n << $1 }
    /^\S*(\d|one|two|three|four|five|six|seven|eight|nine|ten)\S*/.match(line) { |m| n << $1 }
    digits << n
  end
  digits.map(&:to_i)
end



puts part_1(process_data(test_2))
