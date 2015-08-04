require_relative 'bishop'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
class Board
  START = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]
  attr_accessor :grid

  def initialize()
    @grid = Array.new(8) { Array.new(8) }
    populate_grid
  end

  def populate_grid
    grid.size.times do |idx|
      black_pos, white_pos = [1, idx], [6, idx]
      self[black_pos] = Pawn.new(black_pos, self, :black)
      self[[0, idx]] = START[idx].new([0,idx], self, :black)
      self[white_pos] = Pawn.new(white_pos, self, :white)
      self[[grid.size-1, idx]] = START[idx].new([grid.size-1,idx], self, :white)
    end
  end
  
  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0,7) }
  end

  def same_color?(pos1, pos2)
    self[pos1].color == self[pos2].color
  end

end
