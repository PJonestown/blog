class Post < ActiveRecord::Base
  belongs_to :admin

  validates :title, :body, :admin, :presence => true
end
