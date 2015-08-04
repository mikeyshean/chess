require_relative "sliding_piece"
class Rook < SlidingPiece
  DIRECTIONS = [[-1,0], [1,0], [0, 1], [0, -1]]
  attr_reader :color
  def initialize(pos, board, color)
    super(pos, board)
    @color = color
  end

  def move_dirs
    DIRECTIONS
  end
end
