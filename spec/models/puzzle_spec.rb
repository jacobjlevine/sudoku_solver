require 'spec_helper'

describe Puzzle do
  describe "valid puzzle" do
    let(:input) { Array.new(81) {1} }
    before { @puzzle = Puzzle.new(input) }

    subject { @puzzle }

    it { should respond_to :input }
    it { should respond_to :output }
    it { should respond_to :solve }
    it { should respond_to :solved? }


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
