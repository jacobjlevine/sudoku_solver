require 'spec_helper'

describe Puzzle do
  describe "valid puzzle" do
    before do
      @input = Array.new(81) {0}
      @puzzle = Puzzle.new(@input)
    end

    subject { @puzzle }

    it { should respond_to :input }
    it { should respond_to :output }
    it { should respond_to :solve }
    it { should respond_to :solved? }

    describe "should use refresh possibilities algorithm" do
      # test that the algorithm searches row, column, and square
      before do
        number = 1
        [1,4,6,19,20,45,54,63].each do |i|
          @input[i] = number
          number += 1
        end
        @puzzle = Puzzle.new(@input)
        @puzzle.solve
      end

      its(:output) do
        output = @input
        output[0] = 9
        should eq output
      end

    end

    describe "refresh possibilities should run until no more cells are solved" do
      before do
        @input = [9,7,6,5,4,3,0,2,6] + [0]*8 + [7] + [0]*17 + [5] + [0]*8 \
          + [4] + [0]*8 + [3] + [0]*8 + [2] + [0]*8 + [1,1,2,3,4,5,6,7,8,0]
        @puzzle = Puzzle.new(@input)
        puts "test"
        @puzzle.solve
        puts "test"
      end

      its(:output) do
        output = @input
        output[6] = 1
        output[26] = 8
        output[80] = 9
        should eq output
      end

    end

    pending "refresh possibilities should reject puzzles it deems impossible" do

    end
  end

  describe "invalid puzzle" do

    describe "if input not an array" do
      specify { expect { Puzzle.new(1) }.to raise_exception }
    end

    describe "if not 81 numbers in input" do
      let(:too_few) { Array.new(80) {1} }
      let(:just_right) { Array.new(81) {1} }
      let(:too_many) { Array.new(82) {1} }

      specify { expect { Puzzle.new(too_few) }.to raise_exception }
      specify { expect { Puzzle.new(just_right) }.not_to raise_exception }
      specify { expect { Puzzle.new(too_many) }.to raise_exception }
    end

    describe "if input includes values other than 0-9" do
      let(:too_low) { Array.new(81) {-1} }
      let(:right_range) { Array.new(81) { |i| i % 10 } }
      let(:too_high) { Array.new(81) {10} }
      let(:letters) { Array.new(81) {"a"} }

      specify { expect { Puzzle.new(too_low) }.to raise_exception }
      specify { expect { Puzzle.new(right_range) }.not_to raise_exception }
      specify { expect { Puzzle.new(too_high) }.to raise_exception }
      specify { expect { Puzzle.new(letters) }.to raise_exception }
    end
  end
end
