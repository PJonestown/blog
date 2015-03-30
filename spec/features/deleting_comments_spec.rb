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
      click_link 'delete comment'
      expect(current_path).to eq(post_path(@new_post))
      expect(page).not_to have_content(@comment.body)
    end
  end

  context 'an incorrect commenter' do

    background do
      visit post_path(@new_post)
      click_link 'sign out'
      visit post_path(@new_post)
      @unauthorized_commenter = create(:other_commenter)
      commenter_sign_in(@unauthorized_commenter)
    end

    scenario 'does not delete the comment' do
      visit post_path(@new_post)
      expect(page).to have_content(@comment.body)
      expect(page).not_to have_link('delete comment')
    end
  end


  context 'admin' do

    background do
      visit post_path(@new_post)
      click_link 'sign out'
      admin = create(:admin)
      sign_in(admin)
      visit post_path(@new_post)
    end

    scenario 'deletes the comment' do
      expect(page).to have_content(@comment.body)
      click_link 'delete comment'
      expect(current_path).to eq(post_path(@new_post))
      expect(page).not_to have_content(@comment.body)

    end


  end
end

 
