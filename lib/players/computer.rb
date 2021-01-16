require_all 'lib'
class Players::Computer

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
    binding.pry
    input = nil
    raw_input = nil
    WIN_COMBINATIONS.each do |array|
        if array.count {|i| board.cells[i] != self.token && board.cells[i] != " "} > 1
          raw_input = array.detect {|i| board.cells[i] == " "}
          input = "#{raw_input+1}"

        elsif array.count {|i| board.cells[i] == self.token} > 1
          raw_input = array.detect {|i| board.cells[i] == " "}
          input = "#{raw_input+1}"

        elsif array.count {|i| board.cells[i] == " "} == 2
          raw_input = array.detect {|i| board.cells[i] == self.token}
          if array.index(raw_input) > 1 || array.index(raw_input) < 1
            input= "#{array[1]+1}"
          else
            input= (array - [raw_input]).sample
          end

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
      input
  end


end
