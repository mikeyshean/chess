require_relative 'piece'

class SteppingPiece < Piece

  def moves
    valid_moves = []

    move_dirs.each do |coord|
      x,y = coord
      row,col = pos
      new_pos = [row + x, col + y]
      valid_moves << new_pos if board.on_board?(new_pos)
    end

    valid_moves.select { |move| board[move].nil? || gettable_piece(move) }
  end

end
