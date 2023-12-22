#!/usr/bin/env ruby

real_data = File.open('./data.txt').readlines

test_games_1 = [
  'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
  'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
  'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
  'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
  'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green',
]

questioned_counts = {
  'red' => 12,
  'green' => 13,
  'blue' => 14,
}

def process_data(data)
  data.map{ |line| line.chomp }
end

# part 1
class CubeGame
  def initialize(games, questioned_counts)
    @games = games
    @questioned_counts = questioned_counts
    @game_counts = parse_games
  end

  # returns a hash of game_id => { color => maxCount } for each game
  def parse_games
    @games.each_with_object({}) do |game, dictionary|
      game_n, cube_counts = game.split(':')
      id = game_n.split.last.to_i

      dictionary[id] = cube_counts.split(/[,;]/).each_with_object({}) do |n_color, counts|
        n, color = n_color.split
        counts[color] = [(counts[color] || 0), n.to_i].max
      end
    end
  end

  def possible_games
    @game_counts.each_with_object([]) do |(game_id, counts), possibilities|
      if @questioned_counts.all? { |color, n| counts[color] <= n }
        possibilities << game_id
      end
    end
  end

  # part 2
  def minimum_game_powers
    @game_counts.each_with_object([]) do |(_, counts), powers|
      powers << game_cubes_power(counts)
    end.sum
  end

  # multiplies the counts of each color in a red/green/blue hash
  def game_cubes_power(cube_counts)
    cube_keys = %w(red green blue)
    cube_keys.inject(1) do |product, color|
      cube_counts[color] * product
    end
  end
end

# part 1
p CubeGame.new(process_data(real_data), questioned_counts).possible_games.sum

# part 2
p CubeGame.new(process_data(real_data), questioned_counts).minimum_game_powers
