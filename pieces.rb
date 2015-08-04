class Piece

  def initialize(pos, board)
    @pos = pos
    @board = board
  end

  def moves
    self.move_dirs
  end

end
