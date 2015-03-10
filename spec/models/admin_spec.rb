require 'rails_helper'

RSpec.describe Admin, type: :model do

  #let(:admin) { Admin.new(
   # email:                    'email@gmail.com',
    #password:                 'password',
    #password_confirmation:    'password'
  #)}
  let(:admin) { build(:admin) }

  it 'has a valid factory' do 
    expect(admin).to be_valid
  end

  xit 'should be valid' do
    expect(admin).to be_valid
  end

 it 'should return an array of posts' do
   #build(:admin)
   expect(admin.posts).to eq([])
 end
end
