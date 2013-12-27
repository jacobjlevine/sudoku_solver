class Cell
  attr_accessor :possibilities

  def initialize(id, value)
    @id = id
    @value = value
    @possibilities = (value == 0 ? (1..9).to_a : [value])
  end

  def id
    @id
  end

  def row
    @id / 9 + 1
  end

  def column
    @id % 9 + 1
  end

  # squares are counted horizontally from left to right and down
  # the top left square is #1, the top right is #3, the bottom
  # left is #7, etc
  def square
    square_row = @id / 27 + 1
    square_column = (@id % 9) / 3 + 1
    square_row * 3 + square_column - 3
  end

  def value
    if @value == 0 && possibilities.length == 1
      @value = possibilities[0]
    end
    @value
  end

  # returns true if value is not 0
  def solved?
    value != 0
  end

  # remove specified array of values from possibilities
  def forbidden_values(values)
    raise "invalid input" if !values.is_a? Array
    @possibilities -= values
  end
end
