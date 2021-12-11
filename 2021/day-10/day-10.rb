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
    catch :illegal do
    stack = []
    line.chars do |char|
      char_i = bkts.index(char)
      if char_i.even?
        stack << char
        next
      end
      unless bkts[char_i - 1] == stack.pop
        illegals << char
        throw :illegal
      end
      end
    end
  end
  illegals.sum{ |il| scores[il] }
end

p bracket_matcher(test_data)
