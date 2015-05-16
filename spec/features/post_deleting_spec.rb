require 'rails_helper'
include LoginMacros

feature 'deleting a post' do
  background do
    admin = create(:admin)
    sign_in admin
    @my_post = create(:published_post)
  end

  context 'logged in admin' do
    scenario 'it deletes the post' do
      visit post_path(@my_post)
      click_link 'Delete Post'
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
