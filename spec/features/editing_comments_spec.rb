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
      click_link 'Edit Comment'
      fill_in 'Body', with: 'An edited comment'
      click_button 'Update Comment'
      expect(current_path).to eq(post_path(@new_post))
      expect(page).to have_content('An edited comment')
      expect(page).not_to have_content(@comment.body)


    end

  end

  context 'an incorrect commenter' do

    background do
      visit post_path(@new_post)
      click_link 'Sign Out'
      visit post_path(@new_post)
      @unauthorized_commenter = create(:other_commenter)
      commenter_sign_in(@unauthorized_commenter)

    end
    scenario 'does not edit the comment' do
      expect(page).to eq(post_path(@new_post))
      expect(page).to have_content(@comment.body)
      expect(page).not_to have_link('Edit Comment')


    end

  end

  context 'a guest user' do
    scenario 'does not edit the comment' do

    end

  end
end
