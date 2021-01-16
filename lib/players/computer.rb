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
    [2,4,6]
  ]

  def move(board)
    #binding.pry
    input = nil
    raw_input = nil
    binding.pry
    WIN_COMBINATIONS.each do |array|
        if array.count {|i| board.cells[i] != self.token && board.cells[i] != " "} > 1
          raw_input = array.detect {|i| board.cells[i] == " "}
          input = "#{raw_input+1}"

        elsif array.count {|i| board.cells[i] == self.token} > 1
          raw_input = array.detect {|i| board.cells[i] == " "}
          input = "#{raw_input+1}"

        elsif array.count {|i| board.cells[i] == " "} == 2
          if array.include? (self.token)
            raw_input= array.detect {|i| board.cells[i] == self.token}
              if array.index(raw_input) > 1 || array.index(raw_input) < 1
                input= "#{array[1]+1}"
              else
                index= (array - [raw_input]).sample
                input= (index+1).to_s
              end
          else
            raw_input= array.detect {|i| board.cells[i] != " "}
            if board.cells[4] == " "
              input = "5"
            else
              input = ([*1..9] - [raw_input+1]).sample.to_s
        #  me = array.detect {|i| board.cells[i] == self.token || (board.cells[i] != self.token && board.cells[i] != " ")}
          raw_input = array.detect {|i| board.cells[i] == self.token || (board.cells[i] != self.token && board.cells[i] != " ")}


        elsif board.cells.count {|i| i != self.token && i != " "} == 1
          unwanted= nil
          board.cells.each do |element|
            if element != self.token && element != " "
              unwanted = board.cells.index(element)
            end
          end
          raw_input= ([*1..9] - [unwanted]).sample
          input ="#{raw_input}"

        else
          input = "5"

        end

      end
      board.update(input, self)
      input
  end


end
