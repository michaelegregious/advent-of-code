#!/usr/bin/env ruby

# require 'pry'

real_data = File.open('./data.txt').readlines

test_data = [
  "5483143223",
  "2745854711",
  "5264556173",
  "6141336146",
  "6357385478",
  "4167524645",
  "2176841721",
  "6882881134",
  "4846848554",
  "5283751526",
]

def process_data(data)
  data.map{ |line| line.chomp.chars.map(&:to_i) }
end

# single_step = [
  # 1. all nums increase by 1
  # 2. if oct > 9, flash!
  # 3. a flash increases energy level of adjacent (incl. diag)
  #   octs by 1. If oct > 9, flash! Continue as long as any oct > 9.
  # 4. Any 9 returns to 0. (Only one flash per )
# ]

def step(grid)
  flashes = Hash.new(nil)
  length = grid.sum{ |row| row.length }
  wave = 0

  # all octs increase by 1
  grid.each_with_index do |row, y|
    row.each_with_index do |oct, x|
      # if oct == 9
      #   flashes[[y, x]] = 1
      # else
      #   grid[y][x] += 1
      # end
      grid[y][x] += 1
      if grid[y][x] >= 9
        flashes[[y, x]] = wave
      end
    end
  end

  p "flashes: #{flashes}"
  while true
    grid.each_with_index do |row, y|
      row.each_with_index do |oct, x|

        loc = [y, x]
        if oct == 9 && flashes[loc] == 0
          flashes_this_wave << { loc => wave }
        elsif h = check_adjacents(loc, flashes, wave)
          p "adjs: #{h}"
          grid[y][x] += 1
        end
        break if flashes_this_wave.empty?
        wave += 1
        flashes_this_wave.each{ |k, v| flashes[k] = v }
        flashes_this_wave = []
        p "flashes: #{flashes}"
        p "flashes_this_wave? #{flashes_this_wave}"
      end
    end
  end
  p "end"
  grid
end

def check_adjacents((i, j), flashes, wave)
  adjacents = [
    [i - 1, j],
    [i - 1, j+ 1],
    [i, j + 1],
    [i + 1, j + 1],
    [i + 1, j],
    [i + 1, j - 1],
    [i, j - 1],
    [i - 1, j - 1]
  ]
  adjacents.any?{ |adj| wave - flashes[adj] > 1 }
end

data = process_data(test_data)
p step(data)

# n = i > 0 ? rows[i - 1][j] : nil
# ne = i > 0 && j != length ? rows[i - 1][j + 1] : nil
# e = j < length - 1 ? row[j + 1] : nil
# se = j != length ? rows[i + 1][j + 1]
# s = i < length - 1 ? rows[i + 1][j] : nil
# sw = i > j.length - 1 || j == 0 ? nil : rows[i + 1][j - 1]
# w = j == 0 ? nil : row[j - 1]
# nw = i > 0 && j != 0 ? rows[i - 1][j - 1] : nil
