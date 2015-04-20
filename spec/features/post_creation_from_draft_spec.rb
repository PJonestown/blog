#todo why is this failing?

require 'rails_helper'
include LoginMacros

feature 'post creation' do

  context 'from draft' do

    background do
      @admin = create(:admin)
      @draft= create(:post)
      sign_in(@admin)
    end

    it "Should change draft to published" do

      visit edit_post_path(@draft)
      save_and_open_page
      click_button "Publish and save"
      expect(@draft.draft).to eq(false)
    end
  end
end


