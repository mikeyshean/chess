require_relative "pieces"
class SlidingPiece < Piece

  def initialize(pos, board)
    super
  end

  def moves
    valid_moves = []
    move_dirs.each do |coord|
      x,y = coord
      row,col = pos
      new_pos = [row + x, col + y]
      until !board.on_board?(new_pos)
        break if obstructed?(new_pos)
        valid_moves << new_pos
        row += x
        col += y
        new_pos = [row + x, col + y]
      end
    end
    valid_moves
  end

  def obstructed?(new_pos)
    !board[new_pos].nil? && board[new_pos].color == board[pos].color
  end

end
