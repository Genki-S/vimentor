require_relative '../../test_helper'
describe Vimentor do
  it "must be defined" do
    Vimentor::VERSION.wont_be_nil
  end
end
