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
  scores = { ')'=> 3, ']'=> 57, '}'=> 1197, '>'=> 25137 }
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
        next
      end
    end
  end
  illegals
end

def reconstruct_brackets(lines)
  scores = { ')'=> 1, ']'=> 2, '}'=> 3, '>'=> 4 }
  bkts = '{}[]<>()'
  added = Array.new(lines.length){ [] }
  p "added: #{added}"
  lines.each.with_index do |line, i|
    stack = []
    line.chars.reverse_each do |char|
      char_i = bkts.index(char)
      if char_i.odd?
        p "add to stack: #{char}"
        stack << char
        next
      end
      if popped = stack.pop
        next
      else
        p "CHAR: #{char}"
        p "added: #{added.map(&:join)}"
        # stack << bkts[bkts.index(char) + 1]
        added[i] << bkts[bkts.index(char) + 1]
        next
      end
    end
  end
  added
end



lines = process_data(test_data)
corrupted = find_corrupted(lines)


filtered = lines.reject.with_index { |l, i| corrupted.include?(i) }

# p filtered
done = reconstruct_brackets(filtered)

# p done[0].join


