require "pry"
class Game
  attr_accessor :board, :player_1, :player_2

  def initialize(player_1=Players::Human.new('X'), player_2=Players::Human.new('O'), board=Board.new)
  @player_1= player_1
  @player_2= player_2
  @board = board
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]


  def current_player
    board.turn_count.even? ? player_1 : player_2
  end

  def won?
    WIN_COMBINATIONS.detect do |i|
     board.cells[i[0]] == board.cells[i[1]] && board.cells[i[1]] == board.cells[i[2]] && board.taken?((i[0]+1).to_s)
    end
  end

  def draw?
    board.full? && !won?
  end

  def over?
    won? || board.full? || draw?
  end

  def winner
    if won?
      board.cells[won?[0]]
    end
  end

  def turn
        #METHOD 1: SHORT METHOD
      #  binding.pry
    input=current_player.move(board)              #"Current_player.move(board)"" asks for input from player_1
    if board.taken?(input)
      puts "Position already taken"
      turn
    elsif !board.valid_move?(input)
      puts "Invalid input!"
      turn
    elsif board.valid_move?(input)
      board.update(input, current_player)
      puts "Board"
      board.display
      puts "#{current_player.token}'s turn"
    end


        #METHOD 2: LONG METHOD
  #  input=current_player.move(board)
  #  if board.update(input,current_player)
  #    board.update(input,current_player)
  #  else
  #    turn
  #  end
  end

  def play
    #binding.pry
    board.display
    puts "Enter a number between 1 and 9"
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end



end
