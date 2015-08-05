require_relative 'board'
require 'byebug'

class Game
  attr_reader :board, :players
  attr_accessor :current_player

  BOARD_SIZE = 8
  ORD_DELTA = 97

  def initialize
     @board = Board.new
     @players = [:white, :black]
     @current_player = players.first
  end

  def play
    until over?
      play_turn
      switch_player
    end
  end

  def play_turn
    system("clear")
    board.render
    puts "#{current_player.to_s.capitalize}'s Turn:"
    begin
      board.move(*get_move)
    rescue ArgumentError => e
      puts e.message
      retry
    end
  end

  def get_move
    result = []
    puts "Input start piece and end position (ex:'f2,f3'):"
    input = gets.chomp.split(",")

    input.each do |coord|
      col, row = coord.split("")
      row = Integer(row)
      col = String(col).downcase

      raise ArgumentError.new("Invalid position") if !("a".."h").to_a.include?(col)
      raise ArgumentError.new("Invalid position") if !row.between?(1,8)
      result << convert(row, col)
    end
    raise ArgumentError.new("There's no piece there") if board[result.first].nil?
    raise ArgumentError.new("Not your piece") if board[result.first].color != current_player
    result
  end

  def convert(row, col)
    new_row = BOARD_SIZE - row
    new_col = col.ord - ORD_DELTA
    [new_row, new_col]
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
