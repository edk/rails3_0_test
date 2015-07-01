require 'spec_helper'

describe User, :procurement, :core do
  it "add some examples to (or delete) #{__FILE__}" do
    pending
  end

  it "should pass" do
    expect(1).to eq(1)
    puts "yay"
  end
  it "should fail" do
    expect(1).to eq(2), "boooooo"
  end
end

describe "tagless spec" do
  it "does something good" do
  end
  it "fails" do
    expect(42).to eq(43)
  end
end
