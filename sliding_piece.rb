require_relative "piece"
class SlidingPiece < Piece

  def moves
    valid_moves = []

    move_dirs.each do |coord|
      x, y = coord
      row, col = pos
      new_pos = [row + x, col + y]

      until !board.on_board?(new_pos)
        break if blocked_by_own_piece(new_pos)
        valid_moves << new_pos
        break if gettable_piece?(new_pos)
        row += x
        col += y
        new_pos = [row + x, col + y]
      end
    end

    valid_moves
  end

  private

  def blocked_by_own_piece(new_pos)
    obstructed?(new_pos) && board.same_color?(pos, new_pos)
  end

end
