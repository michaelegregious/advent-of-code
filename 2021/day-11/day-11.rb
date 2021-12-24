#!/usr/bin/env ruby

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

def step(grid)
  flashes = Hash.new(nil)
  length = grid.length; width = grid[0].length

  # all octs increase by 1
  grid.each_with_index do |row, y|
    row.each_with_index do |oct, x|
      grid[y][x] += 1
      if grid[y][x] > 9
        flashes[[y, x]] = 0
      end
    end
  end

  wave = 1

  # echoes
  while flashes.has_value?(wave - 1)
    last_flashes = flashes.select{ |fl, w| w == wave - 1}
    last_flashes.each do |flash, w|
      neighbors(flash).each do |(y, x)|
        next if y > length - 1 || x > width - 1 || y < 0 || x < 0
        grid[y][x] += 1
        if grid[y][x] > 9 && !flashes[[y, x]]
          flashes[[y, x]] = wave
        end
      end
    end
    wave += 1
  end

  flashes.each do |(y, x), n|
    grid[y][x] = 0
  end
  [grid, flashes.length]
end

def neighbors((y, x))
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

def dumbo_steps(grid, steps)
  total = 0
  rows = grid
  steps.times do |n|
    rows, flashes = step(rows)
    total += flashes
  end
  total
end

data = process_data(real_data)
p dumbo_steps(data, 100)


