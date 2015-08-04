require_relative 'pieces'

class SteppingPiece < Piece

  def initialize(pos, board, color)
    super
  end

  def moves
    valid_moves = []
    move_dirs.each do |coord|
      x,y = coord
      row,col = pos
      new_pos = [row + x, col + y]
      valid_moves << new_pos if board.on_board?(new_pos)
    end
    valid_moves.select do |move|
      board[move].nil? ||
        (obstructed?(move) && board[pos].color != board[move].color )##!board.same_color?(pos, move))
    end
  end
end
