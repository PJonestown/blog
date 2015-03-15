require 'rails_helper'

RSpec.describe Commenter, type: :model do
  let (:commenter) { build ( :commenter )}
  
  it "has a valid factory" do
    expect(commenter).to be_valid
  end

  it "should have an array of identities" do
    expect(commenter.identities).to eq([])
  end
end

