class Post < ActiveRecord::Base
  belongs_to :admin

  validates :title, :body, :presence => true
end
