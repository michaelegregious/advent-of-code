#!/usr/bin/env ruby

real_data = File.open('./data.txt').readlines

test_1 = [
  'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf'
]

test_data = [
  'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
  'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
  'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
  'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
  'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
  'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
  'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
  'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
  'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
  'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce'
]

Digits = {
  0 => 'abcefg',
  1 => 'cf',
  2 => 'acdeg',
  3 => 'acdfg',
  4 => 'bcdf',
  5 => 'abdfg',
  6 => 'abdefg',
  7 => 'acf',
  8 => 'abcdefg',
  9 => 'abcdfg'
}

Unique_lengths = [1, 4, 7, 8].map{ |n| Digits[n].length }

def process_data(rows)
  rows.map do |row|
    patterns, output = row.split('|')
    [patterns, output].map{ |str| str.split(' ') }
  end
end

# part 1
def unique_digits(rows)
  unique_lengths = [1, 4, 7, 8].map{ |n| Digits[n].length }
  rows.reduce(0) do |count, (_, digits)|
    digits.each do |digit|
      count += 1 if unique_lengths.include?(digit.length)
    end
    count
  end
end

# part 2


rows = process_data(real_data)
# unique_digits(rows)

p unique_digits(rows)



