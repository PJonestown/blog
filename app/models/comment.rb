class Comment < ActiveRecord::Base

  belongs_to :post
  belongs_to :owner, :polymorphic => true

  validates :body, :presence => true

end
