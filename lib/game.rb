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
    input=current_player.move(board)              #"Current_player.move(board)"" asks for input from player_1
    board.update(input,current_player) || turn
        #METHOD 2: LONG METHOD
  #  input=current_player.move(board)
  #  if board.update(input,current_player)
  #    board.update(input,current_player)
  #  else
  #    turn
  #  end
  end

  def play
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

  def start
    "Welcome to Tic Tac Toe"
    "What kind of game would you like to play?"
    "0 players: Computer_1 Vs Computer_2 \nEnter 0 \n1 player: Human Vs Computer \nEnter 1\n 2 players: Player 1 Vs Player 2 \nEnter 2"
    play_mode = gets.strip.to_i
    play_mode
    "Who should go first and be X?"

    case play_mode
      when 0
        "Computer 1: Enter 1;  Computer_2: Enter 2"
        first= gets.strip.to_i
        first == 1 ? Game.new(Players::Computer.new("X"), Players::Computer.new("O")) : Game.new(Players::Computer.new("O"), Players::Computer.new("X"))
        Game.play
      when 1
        "Human: Enter 1;  Compouter: Enter 2"
        first= gets.strip.to_i
        first == 1 ? Game.new(Players::Human.new("X"), Players::Computer.new("O")) : Game.new(Players::Human.new("O"), Players::Computer.new("X"))
        Game.play
      when 2
        "Player 1: Enter 1;  Player 2: Enter 2"
        first= gets.strip.to_i
        first == 1 ? Game.new : Game.new(Players::Human.new("O"), Players::Human.new("X"))
        Game.play
      end

    "Would you like to play again?"
    "If 'Yes' enter 'Y' ; if 'No' enter 'N'"
    decision= gets.strip
    decision == "Y" ? start : break

  end




end
