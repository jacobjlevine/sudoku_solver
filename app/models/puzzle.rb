class Puzzle

  # verify input is an array of 81 integers between 0 and 9.
  # output is initially set to input and then has algorithms applied to it.
  def initialize(input = Array.new(81) {0} )
    if (input.is_a? Array) && (input.length == 81) && input.all? { |a| a.is_a? Integer } \
        && input.min >= 0 && input.max <= 9
      @input = input
      @cells = input.map.with_index { |value,i| Cell.new(i,value) }
    else
      raise "invalid input"
    end
  end

  def input
    @input
  end

  # read the current value of each cell and return array of ints.
  def output
    @cells.map { |a| a.value }
  end

  def solved?
    output.all? { |a| a >= 1 && a <= 9 }
  end

  def solve
    # apply algorithms here
    refresh_possibilities
  end

  private

  # goes through each cell in the puzzle, eliminates impossible
  # values from the possibilities array, and if only a single
  # value remains,
  def refresh_possibilities
    @cells.each do |cell|
      if cell.value == 0
        id = cell.id
        forbidden_values = (get_row_values id) + (get_column_values id) + (get_square_values id)
        cell.forbidden_values(forbidden_values)
      end
    end
  end

  def get_row_values(id)
    row = @cells[id].row
    ids_in_row = ((row-1)*9..row*9-1).to_a
    cells_in_row = ids_in_row.map {|i| @cells[i]}
    get_values(cells_in_row)
  end

  def get_column_values(id)
    column = @cells[id].column
    ids_in_column = (column-1..80).step(9).to_a
    cells_in_column = ids_in_column.map {|i| @cells[i]}
    get_values(cells_in_column)
  end

  def get_square_values(id)
    square = @cells[id].square
    square_row = (square + 2) / 3
    square_column = (square + 2) % 3
    # x is the top leftmost cell in the square
    x = (square_row - 1) * 27 + (square_column * 3)
    ids_in_square = (x..x+2).to_a + (x+9..x+11).to_a + (x+18..x+20).to_a
    cells_in_square = ids_in_square.map {|i| @cells[i]}
    get_values(cells_in_square)
  end

  def get_values(cells)
    cells.map {|cell| cell.value}
  end
end
