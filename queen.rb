require_relative "sliding_piece"

class Queen < SlidingPiece
  DIRECTIONS = [
    [-1,  0],
    [ 1,  0],
    [ 0,  1],
    [ 0, -1],
    [-1,  1],
    [ 1,  1],
    [-1, -1],
    [ 1, -1]
  ]
  def initialize(pos, board, color)
    super
  end

  def move_dirs
    DIRECTIONS
  end
end
