require_relative 'piece'

class Pawn < Piece

  DIRECTIONS = {
    :white => {
      :vertical_delta =>  -1,
      :diagonal_delta => [[-1,-1], [-1,1]],
      :starting_row => 6
    },

    :black => {
      :vertical_delta =>  1,
      :diagonal_delta => [[1,-1],[1, 1]],
      :starting_row => 1
    }
  }

  def moves
    vertical_moves + diagonal_moves
  end

  def to_s
    color == :white ? "\u2659" : "\u265F"
  end

  private

  def vertical_moves
    moves = []
    row, col = pos

    x = DIRECTIONS[color][:vertical_delta]
    new_pos = [row + x, col]
    moves << new_pos unless obstructed?(new_pos) || !board.on_board?(new_pos)

    if row == DIRECTIONS[color][:starting_row]
      one_step_pos, two_step_pos = [row + x, col], [row + (2 * x), col]

      if !obstructed?(one_step_pos) && !obstructed?(two_step_pos)
        moves << two_step_pos
      end
    end

    moves
  end

  def diagonal_moves
    moves = []
    row, col = pos

    DIRECTIONS[color][:diagonal_delta].each do |coord|
      new_pos = [row + coord[0], col + coord[1]]
      moves << new_pos if gettable_piece?(new_pos)
    end
    moves
  end

  # def starting_moves
  #   moves = []
  #   row, col = pos
  #   x = DIRECTIONS[color][:vertical_delta]
  #
  #   if row == DIRECTIONS[color][:starting_row]
  #     one_step_pos, two_step_pos = [row + x, col], [row + (2 * x), col]
  #
  #     if !obstructed?(one_step_pos) && !obstructed?(two_step_pos)
  #       moves << two_step_pos
  #     end
  #   end
  #   moves
  # end
end
