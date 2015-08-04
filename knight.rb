require_relative 'stepping_piece'
class Knight < SteppingPiece

  def initialize(pos, board, color)
    super(pos, board)
    @color = color
  end

  
end
