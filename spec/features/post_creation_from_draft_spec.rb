require 'rails_helper'
include LoginMacros

feature 'post creation' do

  context 'from draft' do

    background do
      @admin = create(:admin)
      @draft= create(:draft)
      sign_in(@admin)
    end

    it "Should create post and delete draft" do

      visit edit_draft_path(@draft)
      #click_button "Publish"
      expect{
        click_button "Publish"
      }.to change(Draft, :count).by(1) &&
           change(Post, :count).by(1)
    end
  end
end


