require 'spec_helper'

describe "Something or other", :core do
  it "add some examples to (or delete) #{__FILE__}" do
    pending
  end

  it "should pass" do
    expect(1).to eq(1)
  end
  it "should fail" do
    expect("abc").to eq("123")
  end
  describe "nested context", :expenses do
    it "will fail yet again" do
      expect(1).to eq(nil)
    end
  end
end

