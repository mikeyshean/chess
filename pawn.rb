require_relative 'pieces'
class Pawn < Piece
  DIRECTIONS = {
    :white => { :vertical => [-1,0], :diagonal => [[-1,-1], [-1,1]], :first_move_row => 6 },
    :black => {:vertical => [1,0], :diagonal => [[1,-1],[1, 1]], :first_move_row => 1 }
  }
  attr_reader :start_move
  def initialize (pos, board, color)
    super
    @start_move = true
  end

  def moves
    valid_moves = []
    (x,_) = DIRECTIONS[color][:vertical]
    row, col = pos
    new_pos = [row + x, col]
    valid_moves << new_pos unless obstructed?(new_pos) || !board.on_board?(new_pos)

    if row == DIRECTIONS[color][:first_move_row]
      new_pos1 = [row + x, col]
      new_pos2 = [row + x + x, col]
      if !obstructed?(new_pos1)
        valid_moves << new_pos1 unless valid_moves.include?(new_pos1)
        valid_moves << new_pos2 if !obstructed?(new_pos2)
      end
    end

    DIRECTIONS[color][:diagonal].each do |coord|
      (x,y) = coord
      row, col = pos
      new_pos = [row + x, col + y]

      if board.on_board?(new_pos) && obstructed?(new_pos) && !board.same_color?(pos, new_pos)
        valid_moves << new_pos
      end
    end

     valid_moves
  end

  def first_move?

  end

  def to_s
    color == :white ? "\u2659" : "\u265F"
  end
end
