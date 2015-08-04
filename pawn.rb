require_relative 'pieces'
class Pawn < Piece
  DIRECTIONS = {
    :white => [[-1,0], [[-1,-1], [-1,1]]],
    :black => [[1,0], [[1,-1],[1, 1]]]
  }
  def initialize (pos, board, color)
    super
  end

  def moves
    valid_moves = []
    (x,_) = DIRECTIONS[color][0]
    row, col = pos
    new_pos = [row + x, col]
    valid_moves << new_pos unless obstructed?(new_pos) || !board.on_board?(new_pos)

    DIRECTIONS[color][1].each do |coord|
      (x,y) = coord
      row, col = pos
      new_pos = [row + x, col + y]

      if board.on_board?(new_pos) && obstructed?(new_pos) && !board.same_color?(pos, new_pos) 
        valid_moves << new_pos
      end
    end

     valid_moves
  end
end
