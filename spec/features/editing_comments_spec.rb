require 'rails_helper'
include LoginMacros

feature 'editing comments' do

  background do
    @new_post = create(:post)
    @commenter = create(:commenter)
    @comment = build(:comment)
    commenter_sign_in(@commenter)
    visit post_path(@new_post)
    fill_in 'Body', with: @comment.body
    click_button 'Create Comment'
  end

  context 'the correct commenter' do

    scenario 'edits the comment' do
      visit post_path(@new_post)
      expect(page).to have_content(@comment.body)
      expect(page).to have_link('Edit Comment')

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
