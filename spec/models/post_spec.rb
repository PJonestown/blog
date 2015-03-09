require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:admin) { Admin.new( 
                  email:                  'email@gmail.com',
                  password:               'foobarfoo',
                  password_confirmation:  'foobarfoo'
  )}

  let!(:post) { admin.post.new(
                  title:    'a title',
                  body:     'a body'
  )}

  xit 'should be valid' do
    expect(post).to be_valid
  end
end

