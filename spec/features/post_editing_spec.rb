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

    end
  end
end
