require 'rails_helper'
include LoginMacros

feature 'comment creation' do
  context 'on posts' do
    background do
      @new_post = create(:published_post)
    end

    context 'commenter logged in' do
      background do
        @commenter = create(:commenter)
        commenter_sign_in(@commenter)
      end

      scenario 'adds a new comment' do
        visit post_path(@new_post)
        expect(page).to have_link("sign out")
        fill_in 'comment_body', with: 'A brand new comment'
        click_button 'Submit'
        expect(current_path).to eq(post_path(@new_post))
        expect(page).to have_content('A brand new comment')
        expect(page).to have_content('kubric')
      end
    end

    context 'admin logged in' do
      background do
        admin = create(:admin)
        sign_in(admin)
      end

      scenario 'adds a new comment' do
        visit post_path(@new_post)
        fill_in 'comment_body', with: 'Admins can comment too!'
        click_button 'Submit'
        expect(current_path).to eq(post_path(@new_post))
        expect(page).to have_content('Admins can comment too!')
      end
    end

    context 'guest user' do
      scenario 'does not add a comment' do
        visit post_path(@new_post)
        expect(page).to have_content 'Sign In to comment'
        expect(page).to have_link('Sign In with Twitter')
        expect(page).to have_link('Sign In with Github')
        expect(page).not_to have_content 'Submit'
      end
    end
  end
end

