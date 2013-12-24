class Puzzle

  # verify input is an array of 81 integers between 0 and 9.
  # output is initially set to input and then has algorithms applied to it.
  def initialize(input = Array.new(81) {0} )
    if (input.is_a? Array) && (input.length == 81) && input.all? { |a| a.is_a? Integer } \
        && input.min >= 0 && input.max <= 9
      @input = input
      @cells = Array.new
      input.each { |a| @cells << Cell.new(a) }
    else
      raise "invalid input"
    end
  end

  def input
    @input
  end

  def output
    output = Array.new
    @cells.each { |a| output << a.value }
    output
  end

  def solved?
    output.all? { |a| a >= 1 && a <= 9 }
  end

  def solve
    # apply algorithms here
  end

end
