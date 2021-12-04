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

balls = data[0]
boards_data = data[2..-1]

def make_board(rows)
  {
    rows: rows.map{ |row| row.split(' ') },
    marked: []
  }
end

def make_boards(boards_data)
  boards = []
  (0..boards_data.length).step(6).each do |i|
    boards << make_board(boards_data[i..i + 4])
  end
  boards
end





p "BALL: #{balls}"
p "BOARDS 2: #{make_boards(boards_data)}"
p "FIRST BOARD: #{make_boards(boards_data)[0][:rows].length}"
