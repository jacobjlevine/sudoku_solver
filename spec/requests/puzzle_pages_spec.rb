require 'spec_helper'

describe "Puzzle pages" do

  subject { page }

  describe "home" do
    before { visit root_path }

    it { should have_title "Welcome to Sudoku Solver!" }
    it { should have_selector "h1", text: "Welcome to Sudoku Solver!" }
    it { should have_selector "div.puzzle", count: 1 }
    it { should have_selector "div.row", count: 9 }
    it { should have_selector "div.cell", count: 81 }

    describe "solve" do
      before { click_button "Solve" }

      it { should have_title "Welcome to Sudoku Solver!" }
    end
  end
end