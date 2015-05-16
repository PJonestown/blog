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
      expect(@draft.draft).to eq(true)
      click_button "Publish and save"
      sign_out
      visit root_path
      expect(page).to have_content(@draft.title)
    end
  end
end


