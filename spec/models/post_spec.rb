require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:admin) { Admin.new( 
                  email:                  'email@gmail.com',
                  password:               'foobarfoo',
                  password_confirmation:  'foobarfoo'        )}

  let!(:post) { admin.posts.new(
                  title:    'a title',
                  body:     'a body'                         )}

  it 'should be valid' do
    expect(post).to be_valid
  end

  it 'should have a title' do
    post.title = nil
    expect(post).not_to be_valid
  end

  it 'should have a body' do
    post.body = nil
    expect(post).not_to be_valid
  end

  it 'should have reference to admin' do
    admin.save
    post.save
    post.admin = nil
    expect(post).not_to be_valid
  end
end

