require_relative "sliding_piece"
class Bishop < SlidingPiece
  attr_reader :color

  DIRECTIONS = [
    [-1,  1],
    [ 1,  1],
    [-1, -1], 
    [ 1, -1]
  ]
  def initialize(pos, board, color)
    super(pos,board)
    @color = color
  end

  def move_dirs
    DIRECTIONS
  end

end
