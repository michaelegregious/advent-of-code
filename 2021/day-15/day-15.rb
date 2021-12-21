#!/usr/bin/env ruby

require 'pqueue'
require 'pry'

real_data = File.open('./data.txt').readlines

test_data = [
  "1163751742",
  "1381373672",
  "2136511328",
  "3694931569",
  "7463417111",
  "1319128137",
  "1359912421",
  "3125421639",
  "1293138521",
  "2311944581"
]

def process_data(data)
  data.map{ |row| row.chomp.split('').map(&:to_i) }
end

# part 1
def risk_number(rows, pos = [0, 0], memo = {})
  return memo[pos] if memo[pos]

  y, x = pos; result = 0
  right = x < rows[0].length - 1 ? rows[y][x + 1] : nil
  down = y < rows.length - 1 ? rows[y + 1][x] : nil

  return 0 if [right, down].compact.empty?

  if !right
    result = down + risk_number(rows, [y + 1, x], memo)
    memo[pos] = result
    return result
  elsif !down
    result = right + risk_number(rows, [y, x + 1], memo)
    memo[pos] = result
    return result
  end

  r = right + risk_number(rows, [y, x + 1], memo)
  d = down + risk_number(rows, [y + 1, x], memo)

  result = d < r ? d : r
  memo[pos] = result
  result
end

# part 2
class AStarRiskNumber
  def initialize(rows)
    @rows = rows
    @queue = PQueue.new([{ pos: [0,0], priority: 0 }]){ |a,b| a[:priority] < b[:priority] }
    @fin = [rows.length - 1, rows[0].length - 1].map{ |x| x * 5 }
    @risk_so_far = { [0,0] => 0 }
    @came_from = { [0,0] => nil }
  end

  def calculate_risk
    while(!@queue.empty?)
      current = pop_queue
      y, x = current

      if current == @fin
        return @risk_so_far[current]
      end

      neighbors = {
        [y - 1, x] => calc_node_risk([y - 1, x]),
        [y, x + 1] => calc_node_risk([y, x + 1]),
        [y + 1, x] => calc_node_risk([y + 1, x]),
        [y, x - 1] => calc_node_risk([y, x - 1])
      }

      neighbors.each do |pos, risk|
        next unless risk

        new_risk = @risk_so_far[current] + risk
        # p "risk_so_far: #{@risk_so_far}"
        if !@risk_so_far.key?(pos) || new_risk < @risk_so_far[pos]
          @risk_so_far[pos] = new_risk
          priority = new_risk + estimate_dist(pos)
          enqueue(pos, priority)
          @came_from[pos] = current

        end
      end

      # return 0 if [up, right, down, left].compact.empty?
      # TODO: Define base case
    end
  end

  private

  def estimate_dist(pos)
    a = (@fin[0] - pos[0]).abs
    b = (@fin[1] - pos[1]).abs
    a + b
  end

  def pop_queue
    hash = @queue.pop
    p "queue: #{hash[:pos]}, #{hash[:priority]}"
    hash[:pos]
  end

  def enqueue(position, priority)
    @queue << { pos: position, priority: priority }
  end

  def calc_node_risk((y, x))
    p "y, x: #{y}, #{x}"
    len = @rows.length; wid = @rows[0].length
    total_len = len * 5; total_wid = wid * 5

    if y < 0 || x < 0 || y > total_len - 1 || x > total_wid - 1
      return nil
    else
      add = x / wid + y / len
      n = @rows[y % len][x % wid]
      n + add > 9 ? n + add - 9 : n + add
    end
  end
end

rows = process_data(test_data)
aStar = AStarRiskNumber.new(rows)
p aStar.calculate_risk
