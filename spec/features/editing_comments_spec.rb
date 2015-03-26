require 'rails_helper'
include LoginMacros

feature 'editing comments' do

  background do
    @new_post = create(:post)
    @commenter = create(:commenter)
    @new_comment = create(:comment)
  end

  context 'the correct commenter' do

    background do
      commenter_sign_in(@commenter)
    end

    scenario 'edits the comment' do

    end

  end

  context 'an incorrect commenter' do
    scenario 'does not edit the comment' do

    end

  end

  context 'a guest user' do
    scenario 'does not edit the comment' do

    end

  end
end
