require_relative 'board'
class Game
  attr_reader :board, :players, :current_player
  BOARD_SIZE = 8
  ORD_DELTA = 96
  def initialize
     @board = Board.new
     @players = [:white, :black]
     @current_player = players.first
  end

  def play
    until over?
      play_turn
    end
  end

  def play_turn
    puts "#{current_player.to_s.capitalize}'s Turn:"
    begin
      board.move(get_move)
    rescue

      retry
    end
  end

  def get_move
    result = []
    puts "Input start piece and end position (ex:'f2,f3'):"
    input = gets.chomp.split(",")
    input.each do |coord|
      col, row = coord.split("")
      raise ArgumentError.new("Invalid position") if !("a".."h").to_a.include?(col)

      raise ArgumentError.new("Invalid position") if !row.between?(1,8)

      result << convert(row, col)
    end

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
  end

end
