require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  before(:each) do

    @admin =  Admin.create(
      email:                     'email@email.com',
      password:                  'password',
      password_confirmation:     'password'
    )

    @post = assign(:post, @admin.posts.create(
      :title => "Title",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    @admin.save
    @post.save
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
