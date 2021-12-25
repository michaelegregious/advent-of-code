#!/usr/bin/env ruby

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
def enumerate_small_caves(graph, node = 'start', path = 'start', paths = [], memo = {})
  if node == 'end'
    return path
  end

  graph[node].each do |cnx|
    next if cnx == 'start' && path.include?(cnx)
    sm_caves = path.scan(/,([[:lower:]]+)/)
    next if sm_caves.uniq.length + 1 < sm_caves.length

    paths << enumerate_small_caves(graph, cnx, "#{path},#{cnx}", paths, memo)
  end

  paths.select{ |path| path.is_a? String }
end

def enumerate_small_caves(graph, node = 'start', path = 'start', paths = [], memo = {})
  return memo[path] if memo[path]
  if node == 'end'
    memo[path] = path
    return path
  end

  graph[node].each do |cnx|
    next if cnx == 'start' && path.include?(cnx)
    sm_caves = path.scan(/,([[:lower:]]+)/)
    next if sm_caves.uniq.length + 1 < sm_caves.length

    paths << enumerate_small_caves(graph, cnx, "#{path},#{cnx}", paths, memo)
  end

  result = paths.select{ |path| path.is_a? String }
  memo[path] = result
  result
end

graph = process_data(test_data)
# paths = enumerate_small_caves(graph)
paths = enumerate_small_caves(graph)
# p paths
p paths.length






