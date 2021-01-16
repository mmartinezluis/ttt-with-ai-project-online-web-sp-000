class Board

  attr_accessor :cells

  def initialize
    @cells = Array.new(9, " ")

  end

  def reset!
    #@cells.reset!
    #reset!(@collect)
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(input)
    index = input.to_i-1
    @cells[index]
  end

  def full?
    @cells.all? {|i| i=="X" || i=="O"}
  end

  def turn_count
    count = 0
    @cells.each do |element|
      if (element =="X" || element =="O")
        count += 1
      end
    end
    count
  end

  def taken?(input)
    position(input) == "X" || position(input) == "O"
  #  index= input.to_i-1
  #  @cells[index] != " "
  end

  def valid_move?(input)
    #index= input.to_i-1
    (0..8).include?(input.to_i-1) && !taken?(input)
  end

  def update(input, player)
    index = input.to_i-1
    if valid_move?(input)
      @cells[index] = player.token
    end
  end

end
