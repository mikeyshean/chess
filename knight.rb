require_relative 'stepping_piece'
class Knight < SteppingPiece
  DIRECTIONS = [
   [-2, -1],
   [-2,  1],
   [-1, -2],
   [-1,  2],
   [ 1, -2],
   [ 1,  2],
   [ 2, -1],
   [ 2,  1]
  ]
  def initialize(pos, board, color)
    super
  end

  def move_dirs
    DIRECTIONS
  end

  def to_s
    color == :white ? "\u2658" : "\u265E"
  end
end
