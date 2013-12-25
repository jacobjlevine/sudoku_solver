class PuzzleController < ApplicationController
  def home
    @puzzle = Puzzle.new
  end

  def solve
    cells = Array.new
    params[:cells].each do |key, value|
      begin
        cells << value.to_i
      rescue Exception=>e
        puts e
        raise "invalid input"
      end
    end
    @puzzle = Puzzle.new(cells)
    @puzzle.solve
    render "home"
  end
end
