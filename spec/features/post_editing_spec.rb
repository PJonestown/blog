require "rails_helper"
include LoginMacros

feature "Editing a post" do

  background do

    admin = create(:admin)
    sign_in admin

    @my_post = build(:post)
    new_post(@my_post.title, @my_post.body) 

  end
  
  context "Logged in admin" do
    scenario "Edits post" do
      
      expect(page).to have_content(@my_post.title)

      click_link 'Edit'
      fill_in 'Title', with: 'Brand new title'
      click_button 'Update Post'

      expect(page).not_to have_content(@my_post.title)
      expect(page).to have_content('Brand new title')

    end
  end

  context "guest user" do
    scenario "Can not edit a post" do

      sign_out

      expect(page).to have_content(@my_post.title)

      expect(page).not_to have_link('Edit')

      #todo why isn't this working
      #Maybe need to set up database cleaner
      #Or it could be faker creating wonky random IDs
      #Probably not that since integration
      visit edit_post_path(1)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('No soup for you!')
    end
  end
end
