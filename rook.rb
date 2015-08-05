require_relative "sliding_piece"
class Rook < SlidingPiece

  def initialize(pos, board, color)
    super
  end

  def move_dirs
    [
      [-1,  0],
      [ 1,  0],
      [ 0,  1],
      [ 0, -1]
    ]
  end

  def to_s
    color == :white ? "\u2656" : "\u265C"
  end
end
