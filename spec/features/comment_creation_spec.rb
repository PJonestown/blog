require 'rails_helper'
include LoginMacros

feature 'comment creation on posts' do


  background do
    @new_post = create(:post)
  end

  context 'commenter logged in' do

    background do
      commenter = create(:commenter)
      commenter_sign_in(commenter)
    end

    scenario 'adds a new comment' do

      visit posts_path
      click_link @new_post.title
  

    end
  end
end
