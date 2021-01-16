class Players::Computer

  def move(board)
    binding.pry
    input =nil
    game.WIN_COMBINATIONS.each do |array|
        if array.count {|i| board.cells[i] != self.token && board.cells[i] != " "} > 1
          raw_input = array.detect {|i| board.cells[i] == " "}
          input = "#{raw_input+1}"

        elsif array.count {|i| board.cells[i] == self.token} > 1
          raw_input = array.detect {|i| board.cells[i] == " "}
          input = "#{raw_input+1}"

        elsif array.count {|i| board.cells[i] == self.token || board.cells[i] == " "} = 3
          raw_input = array.detect {|i| board.cells[i] == self.token}
          if array.index(raw_input) > 1 || array.index(raw_input) < 1
            input= "#{array[1]+1}"
          else
            input="#{array[0]+1}"
          end

        elsif board.cells.count {|i| i != self.token && i != " "} = 1
          unwanted= nil
          board.cells.each do |element|
            if element == "X"
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
