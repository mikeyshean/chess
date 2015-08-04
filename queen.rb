require_relative "sliding_piece"

class Queen
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
    @color = color
  end

  def move_dirs
    DIRECTIONS
  end
end
