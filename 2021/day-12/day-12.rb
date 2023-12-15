#!/usr/bin/env ruby

require 'pry'
require 'set'

real_data = File.open('./data.txt').readlines

test_data = [
  "start-A",
  "start-b",
  "A-c",
  "A-b",
  "b-d",
  "A-end",
  "b-end"
]

test_data0 = [
  "start-A",
  "start-b",
  "b-A",
  "A-end",
  "b-end"
]

test_data1 = [
  'dc-end',
  'HN-start',
  'start-kj',
  'dc-start',
  'dc-HN',
  'LN-dc',
  'HN-end',
  'kj-sa',
  'kj-HN',
  'kj-dc',
]

test_data2 = [
  'fs-end',
  'he-DX',
  'fs-he',
  'start-DX',
  'pj-DX',
  'end-zg',
  'zg-sl',
  'zg-pj',
  'pj-he',
  'RW-he',
  'fs-DX',
  'pj-RW',
  'zg-RW',
  'start-pj',
  'he-WI',
  'zg-he',
  'pj-fs',
  'start-RW'
]

def process_data(lines)
  lines.reduce({}) do |hash, edge|
    node1, node2 = edge.chomp.split('-')
    hash[node1] = (hash[node1] || Set.new).add(node2)
    hash[node2] = (hash[node2] || Set.new).add(node1)
    hash
  end
end

# part 1
def enumerate_paths(graph, node = 'start', path = 'start', paths = [])
  if node == 'end'
    return path
  end

  graph[node].each do |cnx|
    next if cnx[0] != cnx[0].capitalize && path.include?(cnx)
    paths << enumerate_paths(graph, cnx, "#{path},#{cnx}", paths)
  end

  paths.select{ |path| path.is_a? String }
end

# part 2
def enumerate_small_caves(graph, node = 'start', visited = Set.new, small_twice = true)
  def lower(n) /[[:lower:]]/.match(n) end

  visited.add(node) if lower(node)

    binding.pry
  # if /[[:lower:]]/.match(node)
  #   visited.add(node)
  # end

  n_paths = 0

  # puts "v: #{visited}"
  # puts "graph: #{graph}"



  graph[node].each do |nbr|
    if nbr == 'end'
      n_paths += 1
    elsif !visited.include?(nbr)
      n_paths += enumerate_small_caves(graph, nbr, visited, small_twice)
    elsif nbr != 'start' && small_twice
      # puts "small_twice: #{nbr}"
      n_paths += enumerate_small_caves(graph, nbr, visited, false)
    end
  end
  # puts "n_paths: #{n_paths}, node: #{node}, #{graph[node]}"
  n_paths
end

graph = process_data(test_data2)
paths = enumerate_small_caves(graph)
p paths






