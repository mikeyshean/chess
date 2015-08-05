require_relative 'board'
require 'colorize'
require 'byebug'

class Game
  attr_reader :board, :players
  attr_accessor :current_player, :end_pos

  ORD_DELTA = 97
  INPUT_PATTERN = /^[a-h]{1}[1-8]{1}\,[a-h]{1}[1-8]{1}$/

  def initialize
     @board = Board.new
     @players = [:white, :black]
     @current_player = players.first
     @end_pos = nil
  end

  def play
    until over?
      system("clear")
      board.render
      print_previous_play
      play_turn
      switch_player
    end
    system("clear")
    board.render
    print_winner
  end

private

  def play_turn
    begin
      print "\n"
      puts " #{current_player.to_s.capitalize}'s Turn:"
      print "\n"
      move = get_move
      board.move(*convert(move)) if valid_move?(move)
    rescue ArgumentError => e
      system("clear")
      board.render
      print "\n"
      puts e.message.colorize(:red)
      retry
    rescue ChessError => e
      system("clear")
      board.render
      print "\n"
      puts e.message.colorize(:red)
      retry
    ensure
      board.render
    end
  end

  def get_move
    result = []
    print " Input start piece and end position (ex:'f2,f3'): "
    input = gets.chomp
  end

  def valid_move?(input)
    raise ArgumentError.new("Oops! Try again...") if
      INPUT_PATTERN.match(input).nil?
    raise ChessError.new(" There's no piece there!") if
      board[convert(input).first].nil?
    raise ChessError.new(" Not your piece!") if
      board[convert(input).first].color != current_player

    true
  end

  def convert(input)
    result = []
    input = input.split(",")
    input.each do |coord|
      col, row = coord.split("")
      row = Integer(row)
      col = String(col).downcase

      new_row = board.size - row
      new_col = col.ord - ORD_DELTA
      result << [new_row, new_col]
    end
    self.end_pos = result[1]
    result
  end

  def convert_back(row, col)
    new_row = board.size - ((board.size + row) % 8)
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

  def print_previous_play
    if !end_pos.nil?
      puts " #{players.last.to_s.capitalize} #{board[end_pos].class}"\
       " to #{convert_back(*end_pos)}!".colorize(:green)
    end
  end

  def print_winner
    players.rotate!
    puts "#{players.first.capitalize} wins!"
  end
end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
