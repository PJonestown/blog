require 'rails_helper'

RSpec.describe "posts/index", type: :view do

  before(:each) do
    admin = Admin.create(
      email:                        'email@email.com',
      password:                     'password',
      password_confirmation:        'password'
    )

    assign(:posts, [
      admin.posts.create(
        :title => "Title",
        :body => "MyText"
      ),
      
      admin.posts.create(
        :title => "Title",
        :body => "MyText"
      )

    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
