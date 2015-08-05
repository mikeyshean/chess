require_relative 'board'
require 'colorize'
require 'byebug'

class Game
  attr_reader :board, :players
  attr_accessor :current_player, :end_pos

  BOARD_SIZE = 8
  ORD_DELTA = 97

  def initialize
     @board = Board.new
     @players = [:white, :black]
     @current_player = players.first
     @end_pos = nil
  end

  def play
    until over?
      play_turn
      switch_player
    end
  end

  def play_turn
    new_pos = nil

    system("clear")
    board.render
    if !end_pos.nil?
      puts " #{players.last.to_s.capitalize} #{board[end_pos].class}"\
       " to #{convert_back(*end_pos)}!".colorize(:green)
    end

    begin
      puts
      puts " #{current_player.to_s.capitalize}'s Turn:"
      puts
      new_pos = board.move(*get_move)

    rescue ArgumentError => e
      system("clear")
      board.render
      puts
      puts e.message.colorize(:red)
      retry
    rescue
      system("clear")
      board.render
      puts
      puts " Oops! Try again...".colorize(:red)
      retry
    ensure
      board.render
    end
  end

  def get_move
    result = []
    print " Input start piece and end position (ex:'f2,f3'): "
    input = gets.chomp.split(",")

    input.each do |coord|
      col, row = coord.split("")
      row = Integer(row)
      col = String(col).downcase

      raise ArgumentError.new(" Invalid position!") if !("a".."h").to_a.include?(col)
      raise ArgumentError.new(" Invalid position!") if !row.between?(1,8)
      result << convert(row, col)
    end
    raise ArgumentError.new(" There's no piece there!") if board[result.first].nil?
    raise ArgumentError.new(" Not your piece!") if board[result.first].color != current_player
    self.end_pos = result[1]
    result
  end

  def convert(row, col)
    new_row = BOARD_SIZE - row
    new_col = col.ord - ORD_DELTA
    [new_row, new_col]
  end

  def convert_back(row, col)
    new_row = BOARD_SIZE - ((BOARD_SIZE + row) % 8)
    new_col = (col + ORD_DELTA).chr
    "#{new_col}#{new_row}"
  end


  def over?
    board.checkmate?(:white) || board.checkmate?(:black)
  end

  def switch_player
    players.rotate!
    self.current_player = players.first
  end

end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
