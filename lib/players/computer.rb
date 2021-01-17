#require_relative '../players/concerns/Players'
require_all 'lib'
class Players::Computer
  attr_accessor :board

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def move(board)
    input = nil
    raw_input = nil
  #  binding.pry
    WIN_COMBINATIONS.each do |array|
        if (array.count {|i| board.cells[i] == self.token} > 1) && (array.any? {|i| board.cells[i] == " "})   # Choose an winning array that contains two tokens of myslef and that contains one empty space
          raw_input = array.detect {|i| board.cells[i] == " "}                                                # Select the index(element) in the winning array that reprents the empty space
          input = "#{raw_input+1}"                                                                            # Add 1 to the selected index and set the sum equal to the input    (Playing for winning)

        elsif (array.count {|i| board.cells[i] != self.token && board.cells[i] != " "} > 1) && (array.any? {|i| board.cells[i] == " "})     # Choose an winning array that contains two tokens of opposite player and that contains one empty space
            raw_input = array.detect {|i| board.cells[i] == " "}                                                                            # Select the index(element) in the winning array that reprents the empty space
            input = "#{raw_input+1}"                                                                                                        # Add 1 to the selected index and set the sum equal to the input   (Playing for blocking)

        elsif array.count {|i| board.cells[i] == " "} == 2                               # Choose an winning array that contains a single token, whether of myslef or the opposite player
          if array.any? {|i| board.cells[i] == self.token}                                  # If the selected winning array contians one token of myself
            raw_input= array.detect {|i| board.cells[i] == self.token}                        # find the index in the winning array containg the token of myself
              if array.index(raw_input) > 1 || array.index(raw_input) < 1                     # if the token of myself is not in the center posiiton, whether within a row or a column
                input= "#{array[1]+1}"                                                        # set the next move input equal to the center position for that column or row
              else                                                                            # if the token of myslef is in the center position within a column or row
                index= (array - [raw_input]).sample                                           # choose a random index witihn the winning array that does not include the center position
                input= (index+1).to_s                                                         # Add 1 to the chosen index and set it equal to the nest move's input
              end
          else                                                                              # If a winning array contains one token, and the token is not of myself
            raw_input= array.detect {|i| board.cells[i] != " "}                               # Find the position of that token within the chosen array
            if board.cells[4] == " "                                                          # if the toekn is not at position 5 in the board
              input = "5"                                                                     # make my next move's input at position 5 in the board
            else
              index = board.cells.index(" ")                                                # if the oposite player's token is at position 5 on the board, find an emppy space, randomly
              input = (index+1).to_s                                                        # make my nest move's input equual to the radom empty space
            end
          end

        elsif board.cells.all? {|i| i == " "}                                             #  If the board is clear
          input= "5"                                                                      # Take position 5 in the board
        end
    end

    input

  end

end
