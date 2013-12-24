class Cell
  attr_accessor :id
  attr_accessor :value  #should be 0 if unsolved
  attr_accessor :possibilities

  def initialize(value)
    @value = value
  end

  # returns true if value is not 0
  def solved?
    @value != 0
  end

end
