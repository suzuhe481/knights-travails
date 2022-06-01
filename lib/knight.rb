# Class Knight
# Contains the knight's position and an array of its possible moves.
class Knight
  attr_accessor :position, :next_moves

  def initialize(position)
    return if !validate_position(position)

    @position = position
    @next_moves = []
  end

  # Calculates the moves from this knights current start position to the end position given.
  def calculate_moves(start_knight, end_pos)
    # Initializing knight_queue with starting knight.
    knight_queue = []
    knight_queue.append(start_knight)

    # Initializing distance_hash with the starting knight with a distance of 0.
    distance_hash = {}
    distance_hash[start_knight.position] = 0

    # Initializing prev_hash with the starting knight and nil.
    prev_hash = {}
    prev_hash[start_knight.position] = nil

    until knight_queue.empty?
      curr_knight = knight_queue.shift
      curr_pos = curr_knight.position

      # Getting all possible moves(valid or invalid) for current knight.
      possible_moves = []
      possible_moves.append( [(curr_pos[0].ord + 1).chr, curr_pos[1] + 2] )
      possible_moves.append( [(curr_pos[0].ord + 1).chr, curr_pos[1] - 2] )
      possible_moves.append( [(curr_pos[0].ord - 1).chr, curr_pos[1] - 2] )
      possible_moves.append( [(curr_pos[0].ord - 1).chr, curr_pos[1] + 2] )
      possible_moves.append( [(curr_pos[0].ord + 2).chr, curr_pos[1] + 1] )
      possible_moves.append( [(curr_pos[0].ord + 2).chr, curr_pos[1] - 1] )
      possible_moves.append( [(curr_pos[0].ord - 2).chr, curr_pos[1] - 1] )
      possible_moves.append( [(curr_pos[0].ord - 2).chr, curr_pos[1] + 1] )

      # Goes through each possible move.
      possible_moves.each do |move|
        # Only if move is valid.
        if validate_position(move)
          new_knight = Knight.new(move)
          knight_queue.append(new_knight)
          curr_knight.next_moves.append(new_knight)

          # If move hasn't been visited, create it's spot in both the distance and prev hash.
          if !distance_hash.key?(move)
            distance_hash[move] = -1
            prev_hash[move] = -1
          end

          # If distance is -1, it has not been visited. Adjust distance and prev hash.
          if distance_hash[move] == -1
            distance_hash[move] = distance_hash[curr_pos] + 1
            prev_hash[move] = curr_pos
          end
        end
      end

      # Break when the end position has been added.
      break if possible_moves.include?(end_pos)
    end

    return shortest_path(start_knight.position, end_pos, prev_hash)
  end

  private

  # Creates the path from the end to the start and returns the reversed path.
  # Accepts thet starting position, ending position, and hash of the shortest previous position.
  def shortest_path(start_pos, end_pos, prev_hash)
    path = [end_pos]
    curr = end_pos

    until path.last == start_pos
      path.append(prev_hash[curr])
      curr = prev_hash[curr]
    end

    return path.reverse
  end

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
