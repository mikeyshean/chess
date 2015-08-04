require_relative 'stepping_piece'
class King
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
