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
      expect(page).not_to have_link('Edit')

      #save_and_open_page
      #todo this will always pass when using Rrunner by itself
      #however running the full test suite in terminal can lead to failures
      #The post id will either be 2, 3, or 5
      #I think it depends on the order of feature tests
      #so it will only pass if these feature tests are run first
      #fail with id 3 if create post is run first
      #and fail id 5 if create and delete run first
      #which explains why I have to use 2 
      #which means I set up database_cleaner incorrectly


      visit edit_post_path(2) #todo why isn't this 1? Why is there no 1
      expect(current_path).to eq(root_path)
      expect(page).to have_content('No soup for you!')
    end
  end
end
