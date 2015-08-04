class Piece
attr_reader :board, :pos, :color
  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  def moves
    self.move_dirs
  end

  def obstructed?(new_pos)
    !board[new_pos].nil?
  end

  def other_color
    color == :white ? :black : :white
  end
end
