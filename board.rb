require_relative 'bishop'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'
require_relative 'knight'
class Board

  attr_accessor :grid

  def initialize()
    @grid = Array.new(8) { Array.new(8) }
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
