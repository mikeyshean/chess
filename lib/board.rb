require_relative 'pieces/bishop'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'chess_error'
require 'colorize'

class Board
  BACK_ROW_PIECES = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  BOARD_SIZE = 8

  attr_reader :size
  attr_accessor :grid

  def initialize()
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    @size = BOARD_SIZE
    populate_grid
  end

  def render
    color = :default

    BOARD_SIZE.times do |row|
      print "#{BOARD_SIZE - row} "

      BOARD_SIZE.times do |col|
        print " #{self[[row,col]].nil? ? " " : self[[row,col]].to_s} ".colorize(:background => color)
        color = switch_board_color(color)
      end

      color = switch_board_color(color)
      print "\n"
    end

    puts "   #{("a".."h").to_a.join("  ")}"
  end

  def in_check?(color)
    king_position = king_pos(color)
    opponents = all_pieces(self[king_position].other_color)
    opponents.any? { |piece| piece.moves.include?(king_position)}
  end

  def move(start, end_pos)
    piece = self[start]
    raise ChessError.new(" There is no piece there") if piece.nil?

    if piece.valid_moves.include?(end_pos)
      move!(start, end_pos)
    else
      raise ChessError.new(" Invalid Move")
    end

    self
  end

  def move!(start, end_pos)
    piece = self[start]
    update_board(start, end_pos)
    piece.pos = end_pos

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
    pieces.all? { |piece| piece.valid_moves.empty? }
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

  def king_pos(color)
    king = grid.flatten.find { |el| el.is_a?(King) && el.color == color }
    king.pos
  end

  def populate_grid
    BOARD_SIZE.times do |idx|
      black_pos, white_pos = [1, idx], [6, idx]
      self[black_pos] = Pawn.new(black_pos, self, :black)
      self[[0, idx]] = BACK_ROW_PIECES[idx].new([0,idx], self, :black)
      self[white_pos] = Pawn.new(white_pos, self, :white)
      self[[BOARD_SIZE-1, idx]] = BACK_ROW_PIECES[idx].new([BOARD_SIZE-1,idx], self, :white)
    end
  end

end
