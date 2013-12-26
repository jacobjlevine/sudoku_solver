class PuzzleController < ApplicationController
  def home
    @puzzle = Puzzle.new
  end

  def solve
    cells = params[:cells].map {|key, value| value.blank? ? "0" : value }
    @puzzle = Puzzle.new(cells)
    if @puzzle.valid_input?
      @puzzle.solve
      if @puzzle.solved?
        flash.now[:success] = "puzzle solved!"
      else
        flash.now[:alert] = "puzzle unsolved"
      end
    else
      flash.now[:error] = "invalid input"
    end
    render "home"
  end
end
