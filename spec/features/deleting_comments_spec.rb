require 'rails_helper'
include LoginMacros

feature 'deleting comments' do

  background do
    @new_post = create(:post)
    @commenter = create(:commenter)
    @comment = build(:comment)
    commenter_sign_in(@commenter)
    visit post_path(@new_post)
    fill_in 'comment_body', with: @comment.body
    click_button 'Submit'
  end

  context 'the correct commenter' do

    scenario 'deletes the comment' do
      visit post_path(@new_post)
      expect(page).to have_content(@comment.body)
      click_link 'delete'
      expect(current_path).to eq(post_path(@new_post))
      expect(page).not_to have_content(@comment.body)
    end
  end
end

 
