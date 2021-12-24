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
UniqueLengths = {
  2 => 1, # Length => Digit
  4 => 4,
  3 => 7,
  7 => 8
}

# char_map: { encrypted_char: actual_char }
def validate_char_map(patterns, char_map)
  patterns.all? do |pattern|
    Digits.values.include?(
      pattern.chars.map{ |char| char_map[char] }.sort.join
    )
  end
end

def decipher_mapping(row)
  abc = 'abcdefg'
  patterns = row.flatten
  abc.chars.permutation.each do |perm|
    char_map = perm.map{ |c| [c, perm[abc.index(c)] ] }.to_h
    if validate_char_map(patterns, char_map)
      return char_map
    end
  end
end

def decode_output(row, char_map)
  output = row[1]
  output.reduce('') do |n_str, ptrn|
    decoded = ptrn.chars.map{ |c| char_map[c] }.sort.join
    n_str << Digits.key(decoded).to_s
  end.to_i
end

def count_outputs(rows)
  rows.reduce(0) do |count, row|
    char_map = decipher_mapping(row)
    count += decode_output(row, char_map)
  end
end

rows = process_data(real_data)
p count_outputs(rows)

# def narrow(row)
#   patterns, output = row
#   d_map = (0..9).each_with_object({}){ |ch, h| h[ch] = nil }
#   char_map = 'abcdefg'.chars.each_with_object({}){ |ch,h| h[ch] = nil }

#   patterns.each do |pattern|
#     length = pattern.length
#     if UniqueLengths.include?(length) && !d_map[UniqueLengths[length]]
#       d_map[UniqueLengths[length]] = pattern
#     end
#   end

#   'abcdefg'.char.each do |char|
#     if !d_map[1].include?(char) && d_map[7].include?(char)
#       char_map[char] = 'a'
#     elsif Digits[1].include?(char) && !Digits[5].include?(char)
#       char_map[char] = 'c'
#     elsif Digits[8].includes?(char) && !Digits[0].include?(char)
#       char_map[char] = 'd'
#     elsif Digits[8].include?(char) && !Digits[9].include?(char)
#       char_map[char] = 'e'
#     elsif Digits[1].include?(char) && Digits[5].include?(char)
#       char_map[char] = 'f'
#     end
#   end
#   [d_map, char_map]
# end
