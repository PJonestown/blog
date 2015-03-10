class Post < ActiveRecord::Base
  belongs_to :admin

  validates :title, :body, :admin, :presence => true
  validates :title, :length => { maximum: 140 }
end
