require 'byebug'
class Piece
attr_reader :board, :color
attr_accessor :pos

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

  def move_into_check?(end_pos)
    dboard = board.dup
    dboard.move!(pos, end_pos)
    dboard.in_check?(self.color)
  end

  def dup(duped_board)
    self.class.new(pos.dup, duped_board, color)
  end

  def assign_new_pos(pos)
    self.pos = pos
  end

  def valid_moves
    moves.select { |move| !move_into_check?(move) }
  end

end
