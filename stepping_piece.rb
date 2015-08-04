require_relative 'piece'

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
      valid_moves << new_pos
    end
    valid_moves
  end


end
