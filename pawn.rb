require_relative 'pieces'
class Pawn < Piece
  DIRECTIONS = {
    :white => { :vertical_delta => [-1,0], :diagonal_delta => [[-1,-1], [-1,1]], :starting_row => 6 },
    :black => {:vertical_delta => [1,0], :diagonal_delta => [[1,-1],[1, 1]], :starting_row => 1 }
  }
  attr_reader :start_move
  def initialize (pos, board, color)
    super
  end

  def moves
    vertical_moves + starting_moves + diagonal_moves
  end

  def to_s
    color == :white ? "\u2659" : "\u265F"
  end

  private

  def gettable_piece?(pos)
    board.on_board?(pos) && obstructed?(pos) && color != board[pos].color
  end

  def vertical_moves
    moves = []
    row, col = pos

    x, _ = DIRECTIONS[color][:vertical_delta]
    new_pos = [row + x, col]
    moves << new_pos unless obstructed?(new_pos) || !board.on_board?(new_pos)
    moves
  end

  def diagonal_moves
    moves = []
    row, col = pos

    DIRECTIONS[color][:diagonal_delta].each do |coord|
      new_pos = [row + coord[0], col + coord[1]]
      moves << new_pos if gettable_piece?(new_pos)
    end
    moves
  end

  def starting_moves
    moves = []
    row, col = pos
    x, _ = DIRECTIONS[color][:vertical_delta]

    if row == DIRECTIONS[color][:starting_row]
      one_step_pos, two_step_pos = [row + x, col], [row + x + x, col]

      if !obstructed?(one_step_pos)
        moves << one_step_pos unless moves.include?(one_step_pos)
        moves << two_step_pos if !obstructed?(two_step_pos)
      end
    end
    moves
  end
end
