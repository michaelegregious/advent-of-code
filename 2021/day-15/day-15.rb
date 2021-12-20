#!/usr/bin/env ruby

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
  def initialize(rows, start, finish)
    @rows = rows
    @queue = [[0,0]]
    @start = start
    @fin = finish
    @risk_so_far = {}
    @came_from = {}
  end

  def calculate_risk
    while(@queue.any?)
      current = @queue.shift
      position = current.position
      y, x = position

      if position == @fin # || if [up, right, down, left].compact.empty?
        # return
        break
      end

      children = {
        up: [y - 1, x],
        right: [y, x + 1],
        down: [y + 1, x],
        left: [y, x - 1]
      }

      children.compact.each do |k, pos|
        j, i = pos
        new_risk = risk_so_far[current] + rows[j][i]

        if !risk_so_far.key?(pos) || new_risk < risk_so_far[pos]
          risk = calc_height(@rows, pos)
          heur = estimate_dist(pos)
          combined = combined_heur(heur, risk)
          child = Node.new(pos, risk, combined, position)
          enqueue_node(child)
        end
      end

      # return 0 if [up, right, down, left].compact.empty?
      # TODO: Define base case

      reviewed[position] = node
    end
  end

  private

  def enqueue_node(node)
    queue << node
    queue.sort!{ |a,b| b.heuristic <=> a.heuristic }
  end

  def estimate_dist(pos)
    a = (@fin[0] - pos[0]).abs
    b = (@fin[1] - pos[1]).abs
    a + b
  end

  def combined_heur(heur, risk)
    heur + risk
  end

  def calc_height(rows, (y, x))
    len = rows.length; wid = rows[0].length
    total_len = len * 5; total_wid = wid * 5

    if y < 0 || x < 0 || y > total_len - 1 || x > total_wid - 1
      return nil
    else
      add = x / wid + y / len
      n = rows[y % len][x % wid]
      n + add > 9 ? n + add - 9 : n + add
    end
  end
end

rows = process_data(test_data)
p risk_number_x(rows)
