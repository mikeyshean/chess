require_relative "sliding_piece"
class Bishop < SlidingPiece

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
