#!/usr/bin/env ruby

require 'pry'

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

# part 1
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

# part 2
def find_corrupted(lines)
  bkts = '{}[]<>()'
  illegals = []

  lines.each_with_index do |line, i|
    stack = []
    line.chars do |char|
      char_i = bkts.index(char)
      if char_i.even?
        stack << char
        next
      end
      unless bkts[char_i - 1] == stack.pop
        illegals << i
      end
    end
  end
  illegals
end

def reconstruct_brackets(lines)
  bkts = '{}[]<>()'
  added = Array.new(lines.length){ [] }

  lines.each.with_index do |line, i|
    stack = []
    line.chars.reverse_each do |char|
      char_i = bkts.index(char)
      if char_i.odd?
        stack << char
        next
      end
      if popped = stack.pop
      else
        added[i] << bkts[bkts.index(char) + 1]
      end
    end
  end
  added
end

def calculate_scores(additions)
  additions.reduce([]) do |totals, line|
    scores = { ')' =>  1, ']' => 2, '}' => 3, '>' => 4 }
    score = 0
    line.each do |bkt|
      score = (score * 5) + scores[bkt]
    end
    totals << score
  end.sort[additions.length / 2]
end

lines = process_data(real_data)
corrupted = find_corrupted(lines)
filtered = lines.reject.with_index { |l, i| corrupted.include?(i) }
additions = reconstruct_brackets(filtered)

p calculate_scores(additions)
