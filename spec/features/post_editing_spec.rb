require "Rails_helper"
include LoginMacros

feature "Editing a post" do
  background do

    admin = create(:admin)
    sign_in admin

    new_post

  end
  context "Logged in admin" do
    scenario "Edits post" do


      visit_root_path
    end
  end
end
