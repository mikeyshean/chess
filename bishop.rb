require_relative "sliding_piece"
class Bishop < SlidingPiece
  attr_reader :color

  DIRECTIONS = [[-1,1], [1,1], [-1,-1], [1,-1]]
  def initialize(pos, board, color)
    super(pos,board)
    @color = color
  end

  def move_dirs
    valid_moves = []
    DIRECTIONS.each do |coord|
      x,y = coord
      row,col = pos
      new_pos = [row + x, col + y]
      until !board.on_board?(new_pos)
        valid_moves << new_pos #if not_obstructed
        row += x
        col += y
        new_pos = [row + x, col + y]
      end
    end
    valid_moves
  end
end
