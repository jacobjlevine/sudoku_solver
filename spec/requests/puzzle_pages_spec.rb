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

    describe "incomplete solve should render home" do
      before { click_button "Solve" }

      it { should have_title "Welcome to Sudoku Solver!" }
      it { should have_selector "div.alert-alert" }
    end

    describe "complete solve should render home" do
      before do
        def gen_row(first_int)
          (first_int-1..first_int+7).to_a.map {|val| val % 9 + 1}
        end

        input = gen_row(1) + gen_row(4) + gen_row(7) + gen_row(2) + gen_row(5) \
          + gen_row(8) + gen_row(3) + gen_row(6) + gen_row(9)
        input.each_with_index do |val,i|
          fill_in "cells[#{i}]", with: val
        end
        click_button "Solve"
      end

      it { should have_title "Welcome to Sudoku Solver!" }
      it { should have_selector "div.alert-success" }
    end

    describe "invalid inputs" do

      describe "numbers out of range" do
        before do
          fill_in "cells[0]", with: "12"
          click_button "Solve"
        end

        it { should have_title "Welcome to Sudoku Solver!" }
        it { should have_selector "div.alert-error" }
      end

      describe "letters" do
        before do
          fill_in "cells[0]", with: "a"
          click_button "Solve"
        end

        it { should have_title "Welcome to Sudoku Solver!" }
        it { should have_selector "div.alert-error" }
      end
    end
  end
end