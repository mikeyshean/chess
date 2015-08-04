require_relative "pieces"
class SlidingPiece < Piece

  def initialize(pos, board)
    super
  end

  def moves
    move_dirs
  end

end
