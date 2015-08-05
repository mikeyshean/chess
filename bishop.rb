require_relative "sliding_piece"
class Bishop < SlidingPiece

  def initialize(pos, board, color)
    super
  end

  def move_dirs
    [
      [-1,  1],
      [ 1,  1],
      [-1, -1],
      [ 1, -1]
    ]
  end

  def to_s
    color == :white ? "\u2657" : "\u265D"
  end
end
