# Class Board
# Contains a single knight object.
class Board
  attr_accessor :knight

  def initialize
    @knight = nil
  end

  # Accepts a start and end position for a knight and outputs the shortest path between them.
  def knight_moves(start_pos, end_pos)
    if !validate_position(start_pos) || !validate_position(end_pos)
      return
    end

    knight = Knight.new(start_pos)

    path = knight.calculate_moves(knight, end_pos)
    path_pretty_print(path)
  end

  # Prints the given path with arrows.
  def path_pretty_print(path)
    puts "Shortest path between #{path.first} and #{path.last} is..."
    path.each_with_index do |move, index|
      if index == (path.count - 1)
        print "#{move}"
      else
        print "#{move} --> "
      end
    end
    puts ""
  end

  private
  
  # Determines if a position is a valid location on the board.
  # Position must consist of an array with 2 elements.
  # X position: A single letter between a-h
  # Y position: A single number between 1-8
  def validate_position(pos)
    x_pos_reg_exp = /^[a-h]$/
    y_pos_reg_exp = /^[1-8]$/

    return true if pos[0].match(x_pos_reg_exp) && pos[1].to_s.match(y_pos_reg_exp)

    return false
  end
end
