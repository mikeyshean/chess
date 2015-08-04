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

  def to_s
    color == :white ? "\u2655" : "\u265B"
  end
end
