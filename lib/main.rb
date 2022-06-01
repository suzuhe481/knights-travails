require_relative "knight.rb"
require_relative "board.rb"

board = Board.new

# Driver test code

# Creates an array of random letters between a-h
random_letters = (0...10).map { (97 + rand(8)).chr }

# Creates an array of random numbers between 1-8
random_numbers = (0...10).map { rand(1..8) }

# Creates moves.
# Must be an even number to match a start with an end.
random_moves = random_letters.zip(random_numbers)

# p random_moves

random_moves.each_with_index do |start, index|
  if index.even?
    puts "Start: #{start}" 
    puts "End: #{random_moves[index + 1]}"

    board.knight_moves(start, random_moves[index + 1])
    puts ""
  end
end