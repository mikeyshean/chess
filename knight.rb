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
    super(pos, board)
    @color = color
  end

  def move_dirs
    DIRECTIONS
  end
end
