require 'rails_helper'
include LoginMacros

feature 'deleting a post' do
  background do
    admin = create(:admin)
    sign_in admin

    @my_post = build(:post)
    new_post(@my_post.title, @my_post.body)

  end

  context 'logged in admin' do
    scenario 'it deletes the post' do
      visit root_path
      click_link 'Destroy'
      expect(page).to have_content('Post was successfully destroyed')
      expect(page).not_to have_content(@my_post.title)
    end
  end

  context 'guest user' do
    scenario 'it does not delete post' do
      sign_out
      expect(current_path).to eq(root_path)
      expect(page).not_to have_content('Destroy')
    end
  end
end
