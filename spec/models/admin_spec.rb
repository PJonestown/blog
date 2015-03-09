require 'rails_helper'

RSpec.describe Admin, type: :model do

  let(:admin) { Admin.new(
    email:                    'email@gmail.com',
    password:                 'password',
    password_confirmation:    'password'
  )}

  it 'should be valid' do
    expect(admin).to be_valid
  end
end
