require "rails_helper"
include LoginMacros

feature "Editing a post" do
  background do

    admin = create(:admin)
    sign_in admin

    new_post('A new title', 'A new body') 


  end
  context "Logged in admin" do
    scenario "Edits post" do
      expect(page).to have_content('A new title')

    end
  end
end
