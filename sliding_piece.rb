relative_require "piece"
class SlidingPiece < Piece

  def initialize(pos, board)
    super
  end

  def moves
    move_dirs
  end

end
