#!/usr/bin/env ruby

# require 'pry'

real_data = File.open('./data.txt').readlines

test_1 = [
  "11111",
  "19991",
  "19191",
  "19991",
  "11111"
]

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
  p "initial grid: #{grid}"
  flashes = Hash.new(nil)
  length = grid.length; width = grid[0].length
  wave = 0

  # all octs increase by 1
  grid.each_with_index do |row, y|
    row.each_with_index do |oct, x|
      grid[y][x] += 1
      if grid[y][x] > 9
        flashes[[y, x]] = wave
      end
    end
  end

  wave += 1

  while flashes.has_value?(wave - 1)
    puts "flashes: #{flashes}"
    last_flashes = flashes.select{ |fl, w| w == wave - 1}
    puts "last Flashes: #{last_flashes}"
    # puts "flashes: #{flashes}"
    last_flashes.each do |flash, w|

      adjacents(flash).each do |(y, x)|
        next if y > length - 1 || x > width - 1 || y < 0 || x < 0
        grid[y][x] += 1
        if grid[y][x] >= 9 && !flashes[[y, x]]
          flashes[[y, x]] = wave
        end
      end
    end
    wave += 1
  end
  # p "final flashes: #{flashes}"
  grid.map do |row|
    row.map{ |n| n > 9 ? 0 : n  }
  end
  # grid
end

def adjacents((y, x))
  [
    [y - 1, x],
    [y - 1, x + 1],
    [y, x + 1],
    [y + 1, x + 1],
    [y + 1, x],
    [y + 1, x - 1],
    [y, x - 1],
    [y - 1, x - 1]
  ]
end

def dumbo_steps(steps)
  steps.times{ |n| }
end

data = process_data(test_data)
rows = step(data)
p rows
# p step(rows)

# n = i > 0 ? rows[i - 1][j] : nil
# ne = i > 0 && j != length ? rows[i - 1][j + 1] : nil
# e = j < length - 1 ? row[j + 1] : nil
# se = j != length ? rows[i + 1][j + 1]
# s = i < length - 1 ? rows[i + 1][j] : nil
# sw = i > j.length - 1 || j == 0 ? nil : rows[i + 1][j - 1]
# w = j == 0 ? nil : row[j - 1]
# nw = i > 0 && j != 0 ? rows[i - 1][j - 1] : nil
