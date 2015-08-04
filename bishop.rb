require_relative "sliding_piece"
class Bishop < SlidingPiece

  DIRECTIONS = [
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
    color == :white ? "\u2657" : "\u265D"
  end
end
