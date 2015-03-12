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

  def sign_out
    visit root_path
    click_link 'Sign out'
    expect(current_path).to eq(root_path)
  end

  def new_post(title, body)
    visit root_path
    click_link 'New Post'
    fill_in 'Title', with: title 
    fill_in 'Body', with: body
    click_button 'Create Post'
  end
end
