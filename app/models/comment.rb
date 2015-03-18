class Comment < ActiveRecord::Base

  has_ancestry

  belongs_to :admin

  belongs_to :commenter

  belongs_to :post, :polymorphic => true

  belongs_to :commentable, :polymorphic => true
  has_many :comments, :as => :commentable

end