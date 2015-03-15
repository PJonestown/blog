require 'rails_helper'

RSpec.describe Commenter, type: :model do
  let (:commenter) { build ( :commenter )}
  
  it "has a valid factory" do
    expect(commenter).to be_valid
  end
end

