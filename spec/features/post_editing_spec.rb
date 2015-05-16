require "rails_helper"
include LoginMacros

feature "Editing a post" do
  background do
    admin = create(:admin)
    sign_in admin
    @my_post= create(:post) 
  end

  context "Logged in admin" do
    scenario "Edits post" do
      visit drafts_path
      click_link @my_post.title
      click_link 'Edit Post'
      fill_in 'Title', with: 'Brand new title'
      click_button 'Publish and save'
      expect(page).not_to have_content(@my_post.title)
      expect(page).to have_content('Brand new title')
    end
  end

  context "guest user" do
    scenario "Can not edit a post" do
      sign_out
      expect(page).not_to have_link('Edit')
      visit edit_post_path(@my_post)
      expect(current_path).to eq(root_path)
    end
  end
end
