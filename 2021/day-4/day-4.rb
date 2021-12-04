#!/usr/bin/env ruby

raw_data = File.open('./data.txt').readlines

# def process_raw_data(data)
#   data.map(&:chomp)
# end

test_data = [
  "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1",
  "",
  "22 13 17 11  0",
  "8  2 23  4 24",
  "21  9 14 16  7",
  "6 10  3 18  5",
  "1 12 20 15 19",
  "",
  "3 15  0  2 22",
  "9 18 13 17  5",
  "19  8  7 25 23",
  "20 11 10 24  4",
  "14 21 16 12  6",
  "",
  "14 21 17 24  4",
  "10 16 15  9 19",
  "18  8 23 26 20",
  "22 11 13  6  5",
  "2  0 12  3  7"
]

data = test_data

balls = data[0].split(',')
boards_data = data[2..-1]

def make_board(rows)
  {
    rows: rows.map{ |row| row.split(' ') },
    marked: [],
    bingo: false
  }
end

def make_boards(boards_data)
  boards = []
  (0..boards_data.length).step(6).each do |i|
    boards << make_board(boards_data[i..i + 4])
  end
  boards
end

def mark_board(board, ball)
  board[:rows].each_with_index do |row, row_n|
    row.each_with_index do |num, col_n|
      if ball == num
        board[:marked] << [col_n, row_n]
      end
    end
  end
end

def mark_boards(boards, ball)
  boards.each{ |board| mark_board(board, ball) }
end

Diagonals = [[[0, 0], [1, 1], [2, 2], [3, 3], [4, 4]], [[0, 4], [1, 3], [2, 2], [3, 1], [4, 0]]]

def score_board(board)
  row_scores = [0, 0, 0, 0, 0]
  col_scores = [0, 0, 0, 0, 0]
  diag_scores = [[], []]
  board[:marked].each do |square|
    col_scores[square[0]] += 1
    row_scores[square[1]] += 1
    diag_scores[0] = Diagonals[0].select { |pair| pair == square }
    diag_scores[1] = Diagonals[1].select { |pair| pair == square }
  end
  # p "BOARD scores: #{row_scores}, #{col_scores}, #{diag_scores}"
  if [*row_scores, *col_scores].any?{ |score| score == 5 }
    return true
  elsif diag_scores.any?{ |score| score.length == 5 }
    return true
  else
    return false
  end
end

def play_round(boards, ball)
  boards.each_with_index do |board|
    mark_board(board, ball)
    return board if score_board(board)
  end
  return nil
end

def play_game(boards, balls)
  balls.each do |ball|
    if winner = play_round(boards, ball)
      return [winner, ball]
    end
  end
end

def calculate_score(board, ball)
  unmarked_squares = []
  board[:rows].each_with_index do |row, row_n|
    row.each_with_index do |num, col_n|
      unless board[:marked].include?([col_n, row_n])
        unmarked_squares << num
      end
    end
  end
  unmarked_squares.sum{ |str| str.to_i } * ball.to_i
end

test_boards = make_boards(boards_data)

winner, ball = play_game(test_boards, balls)

p calculate_score(winner, ball)


