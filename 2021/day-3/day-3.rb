#!/usr/bin/env ruby

data = File.open('./data.txt').readlines

test_data = %w(
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
)

def run_diagnostics(binary)
  # tally: [ 0 count, 1 count ] per index
  tally = []
  x = 0

  binary.each do |str|
    str.chomp.chars.each_with_index do |char, i|
      tally[i] ||= [0, 0]
      if char == '0'
        tally[i][0] += 1
      elsif char == '1'
        tally[i][1] += 1
      end
    end
  end

  gamma = tally
    .map { |pair| pair[0] > pair[1] ? 0 : 1 }
    .join
    .to_i(2)

  epsilon = tally
    .map { |pair| pair[0] < pair[1] ? 0 : 1 }
    .join
    .to_i(2)

  gamma * epsilon
end

p run_diagnostics(test_data)
