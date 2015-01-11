require 'spec_helper'

describe User, :component => [:invoicing, :core] do
  it "add some examples to (or delete) #{__FILE__}" do
    pending
  end

  it "should pass" do
    expect(1).to eq(1)
  end
  it "should fail" do
    expect(1).to eq(2)
  end
end

