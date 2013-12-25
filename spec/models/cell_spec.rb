require 'spec_helper'

describe Cell do
  before { @cell = Cell.new(25,0) }

  subject { @cell }

  it { should respond_to :id }
  it { should respond_to :row }
  it { should respond_to :column }
  it { should respond_to :square }
  it { should respond_to :value }
  it { should respond_to :possibilities }
  it { should respond_to :forbidden_values }
  it { should respond_to :solved? }

  its(:row) { should eq 3 }
  its(:column) { should eq 8 }
  its(:square) { should eq 3 }

  describe "unsolved" do
    its(:value) { should eq 0 }
    its(:solved?) { should_not be_true }
  end

  describe "solved" do
    before { @cell.possibilities = [1] }

    its(:value) { should eq 1 }
    its(:solved?) { should be_true }
  end
end
