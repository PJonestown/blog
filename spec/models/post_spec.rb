require 'rails_helper'

RSpec.describe Post, type: :model do
  
  let(:post) { build(:post) }

  it 'should be valid' do
    expect(post).to be_valid
  end

  it 'should have a title' do
    post.title = nil
    expect(post).not_to be_valid
  end

  it 'should not have a title longer than 140 characters' do
    post.title = 'a' * 141
    expect(post).not_to be_valid
  end

  it 'should have a body' do
    post.body = nil
    expect(post).not_to be_valid
  end

  it 'should have reference to admin' do
    post.admin = nil
    expect(post).not_to be_valid
  end

  it 'should have somments' do
    expect(post.comments).to eq([])
  end

end

