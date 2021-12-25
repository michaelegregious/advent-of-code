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

graph = process_data(test_data2)

paths = enumerate_paths(graph)
p paths
p paths.length




