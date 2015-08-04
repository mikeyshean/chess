require_relative 'stepping_piece'
class King
  def initialize(pos, board, color)
    super(pos, board)
    @color = color
  end
end
