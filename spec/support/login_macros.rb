module LoginMacros

  #todo change file name to integration_helper
  #module IntegrationHelper
  #
  #todo include Integration helper in all dependent files
  #
  #todo change to Integration helper in rails_helper

  def sign_in(admin)
    visit new_admin_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'
  end

  def new_post
    visit root_path
    click_link 'New Post'
    fill_in title, with: 'A new title' #todo factory?
    fill_in body, with: 'A new body'
    click_button 'Create Post'
  end
end
