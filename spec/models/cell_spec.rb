require 'spec_helper'

describe Cell do
  before { @cell = Cell.new(0) }

  subject { @cell }

  it { should respond_to :value }
  it { should respond_to :possibilities }
  pending { should respond_to :update_possibilities }
  it { should respond_to :solved? }

  describe "unsolved" do
    its(:value) { should eq 0 }
    its(:solved?) { should_not be_true }
  end

  describe "solved" do
    before { @cell.value = 1 }

    its(:value) { should eq 1 }
    its(:solved?) { should be_true }
  end
end
