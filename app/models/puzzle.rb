class Puzzle

  # verify input is an array of 81 integers between 0 and 9.
  # output is initially set to input and then has algorithms applied to it.
  def initialize(input = Array.new(81) {"0"} )
    @input = input
    if (input.is_a? Array) && (input.length == 81) && input.all? {|s| s.length == 1} \
        && input.min >= "0" && input.max <= "9"
      @cells = input.map.with_index { |value,i| Cell.new(i,value.to_i) }
      @valid_input = true
    else
      @valid_input = false
    end
  end

  def input
    @input
  end

  def valid_input?
    @valid_input
  end

  # read the current value of each cell and return array of ints.
  def output
    if valid_input?
      @cells.map { |a| a.value.to_s }
    else
      input
    end
  end

  def solved?
    if valid_input?
      output.all? { |a| a >= "1" && a <= "9" }
    else
      false
    end
  end

  def solve
    if valid_input?
      # apply algorithms here; run algorithms in order until one of them
      # returns true; then run algorithms again
      if refresh_possibilities || possible_locations
        solve
      end
    end
    valid_input?
  end

  #private

  # goes through each cell in the puzzle, eliminates impossible
  # values from the possibilities array; if the algorithm
  # successfully identifies the value of any cells, return true
  def refresh_possibilities
    success = false
    @cells.each do |cell|
      if cell.value == 0
        cell_id = cell.id
        forbidden_values = (get_forbidden_values cell_id, :row) + (get_forbidden_values cell_id, :column) \
                            + (get_forbidden_values cell_id, :square)
        cell.forbidden_values(forbidden_values)
        success = true if cell.value != 0
      end
    end
    success
  end

  # goes through each row, column, and square and identifies if
  # there are any possible values that only have one possible
  # cell in which they can reside; if the algorithm successfully
  # identifies the value of any cells, return true
  def possible_locations
    success = false
    sets = [:row,:column,:square]
    nums = (1..9).to_a
    sets.each do |set|
      nums.each do |num|
        cells = get_cells set, num
        solved_values = get_values cells
        unsolved_values = nums - solved_values
        # check if any values only have one possible cell
        unsolved_values.each do |val|
          possible_cells = cells.select {|cell| val.in? cell.possibilities}
          if possible_cells.length == 1
            possible_cells[0].possibilities = [val]
            success = true
          end
        end
      end
    end
    success
  end

  # set can be :row, :column, or :square; method returns the solved
  # values in the same set as the cell with cell_id.
  def get_forbidden_values(cell_id, set)
    cell = @cells[cell_id]
    if set == :row
      set_num = cell.row
    elsif set == :column
      set_num = cell.column
    elsif set == :square
      set_num = cell.square
    else
      raise "invalid :set"
    end
    cells_in_set = get_cells(set, set_num)
    get_values(cells_in_set)
  end

  def get_values(cells)
    cells.map {|cell| cell.value}
  end

  # set can be :row, :column, or :square; method returns all cells in
  # the specified set (e.g. get_cells(:row,3) => cells in the 3rd row)
  def get_cells(set, set_num)
    if set == :row
      ids_in_set = ((set_num-1)*9..set_num*9-1).to_a
    elsif set == :column
      ids_in_set = (set_num-1..80).step(9).to_a
    elsif set == :square
      square_row = (set_num + 2) / 3
      square_column = (set_num + 2) % 3
      # x is the top leftmost cell in the square
      x = (square_row - 1) * 27 + (square_column * 3)
      ids_in_set = (x..x+2).to_a + (x+9..x+11).to_a + (x+18..x+20).to_a
    else
      raise "invalid :set"
    end
    ids_in_set.map {|i| @cells[i]}
  end
end
