require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
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

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "input#post_title[name=?]", "post[title]"

      assert_select "textarea#post_body[name=?]", "post[body]"
    end
  end
end
