require_relative 'board'
class Game
  attr_reader :board, :players, :current_player

  def initialize
     @board = Board.new
     @players = [:white, :black]
     @current_player = players.first
  end



  def over?
    board.checkmate?(:white) || board.checkmate?(:black)
  end
  
  def switch_player
    players.rotate!
  end

end
