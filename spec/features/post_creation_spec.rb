require 'rails_helper'

feature 'Post creation' do
  context 'admin logged in' do
    scenario 'adds a new post' do

      admin = create(:admin)

      visit new_admin_session_path
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: admin.password
      click_button 'Log in'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('New Post')
      click_link('New Post')
      
      expect(current_path).to eq(new_post_path)
      fill_in 'Title', with: "A new title"
      fill_in 'Body', with: "The body"
      expect(page).not_to have_content('Admin')
      click_button 'Create Post'

      expect(current_path).to eq(root_path)
      expect(page).to have_content 'A new title'
      
    end
  end

  context 'guest user' do
    scenario 'it does not create a new post' do

      visit root_path
      expect(page).not_to have_content('New Post')

      visit new_post_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content("No soup for you!")

    end
  end
end
