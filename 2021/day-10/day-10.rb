#!/usr/bin/env ruby

real_data = File.open('./data.txt').readlines

test_data = [
  "[({(<(())[]>[[{[]{<()<>>",
  "[(()[<>])]({[<{<<[]>>(",
  "{([(<{}[<>[]}>{[]{[(<()>",
  "(((({<>}<{<{<>}{[]{[]{}",
  "[[<[([]))<([[{}[[()]]]",
  "[{[{({}]{}}([{[{{{}}([]",
  "{<[[]]>}<{[{[{[]{()[[[]",
  "[<(<(<(<{}))><([]([]()",
  "<{([([[(<>()){}]>(<<{{",
  "<{([{{}}[<[[[<>{}]]]>[]]"
]

def process_data(data)
  data.map(&:chomp)
end

def bracket_matcher(lines)
  scores = { ')'=> 3, ']'=> 57, '}'=> 1197, '>'=> 25137 }
  bkts = '{}[]<>()'
  illegals = []

  lines.each do |line|
    stack = []
    line.chars do |char|
      char_i = bkts.index(char)
      if char_i.even?
        stack << char
        next
      end
      unless bkts[char_i - 1] == stack.pop
        illegals << char
        next
      end
    end
  end
  illegals.sum{ |il| scores[il] }
end

data = process_data(real_data)
p bracket_matcher(data)
