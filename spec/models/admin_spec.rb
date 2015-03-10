require 'rails_helper'

RSpec.describe Admin, type: :model do

  let(:admin) { build(:admin) }

  it 'has a valid factory' do 
    expect(admin).to be_valid
  end

 it 'should return an array of posts' do
   expect(admin.posts).to eq([])
 end

end
