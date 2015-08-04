require_relative 'bishop'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require 'colorize'
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

  def render
    color = :default
    puts "  #{("a".."h").to_a.join(" ")}"
    grid.size.times do |row|
      print "#{grid.size - row} "
      grid.size.times do |col|
        print "#{self[[row,col]].nil? ? " " : self[[row,col]].to_s} ".colorize(:background => color)
        color = (color == :default ? :white : :default )
      end
      color = (color == :default ? :white : :default )
      puts
    end
  end

  def in_check?(color)
    king_pos = find_king(color)
    opponents = grid.flatten.select { |el| el.is_a?(Piece) && el.color != color}
    opponents.any? { |piece| piece.moves.include?(king_pos)}
  end

  def find_king(color)
    king_pos = grid.flatten.select { |el| el.is_a?(King) && el.color == color }
    king_pos[0].pos
  end

  def move(start, end_pos)
    piece = self[start]
    raise ArgumentError.new("There is no piece there")  if piece.nil?
    if piece.moves.include?(end_pos)
      self[end_pos] = piece
      self[start] = nil
    else
      raise ArgumentError.new("Invalid Move")
    end
    self
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

  def dup
    dup_board = Board.new
    dup_board.grid.map! { |el| el.is_a?(Piece) ? el.dup(dup_board) : el }
    dup_board
  end
end
