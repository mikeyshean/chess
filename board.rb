require_relative 'bishop'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require 'colorize'

class Board
  START = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  attr_accessor :grid

  def initialize()
    @grid = Array.new(8) { Array.new(8) }
    populate_grid
  end

  def render
    color = :default

    grid.size.times do |row|
      print "#{grid.size - row} "

      grid.size.times do |col|
        print " #{self[[row,col]].nil? ? " " : self[[row,col]].to_s} ".colorize(:background => color)
        color = switch_board_color(color)
      end

      color = switch_board_color(color)
      puts
    end

    puts "   #{("a".."h").to_a.join("  ")}"
  end

  def in_check?(color)
    king_pos = find_king_pos(color)
    opponents = all_pieces(self[king_pos].other_color)
    opponents.any? { |piece| piece.moves.include?(king_pos)}
  end

  def move(start, end_pos)
    piece = self[start]
    raise ArgumentError.new(" There is no piece there") if piece.nil?

    if piece.valid_moves.include?(end_pos)
      move!(start, end_pos)
    else
      raise ArgumentError.new(" Invalid Move")
    end

    self
  end

  def move!(start, end_pos)
    piece = self[start]
    update_board(start, end_pos)
    piece.assign_new_pos(end_pos)

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
    dup_board.grid = self.grid.map do |row|
      row.map { |el| el.is_a?(Piece) ? el.dup(dup_board) : el }
    end
    dup_board
  end

  def checkmate?(color)
    pieces = all_pieces(color)
    pieces.all? { |piece| piece.valid_moves.count == 0 }
  end

private

  def all_pieces(color)
    pieces = grid.flatten.select { |el| el.is_a?(Piece) && el.color == color}
  end

  def switch_board_color(color)
    color == :default ? :white : :default
  end

  def update_board(start, end_pos)
    piece = self[start]
    self[end_pos] = piece
    self[start] = nil
  end

  def find_king_pos(color)
    king = grid.flatten.find { |el| el.is_a?(King) && el.color == color }
    king.pos
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

end
