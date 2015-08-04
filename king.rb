require_relative 'stepping_piece'
class King < SteppingPiece
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
    color == :white ? "\u2654" : "\u265A"
  end
end
