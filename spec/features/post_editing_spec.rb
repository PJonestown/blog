require "Rails_helper"

feature "Editing a post" do
  background do

  end
  context "Logged in admin" do
    scenario "Edits post" do

      admin = create(:admin)

      visit_root_path
    end
  end
end
