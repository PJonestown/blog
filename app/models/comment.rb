class Comment < ActiveRecord::Base
  belongs_to :commenter

  belongs_to :post, :polymorphic => true

  belongs_to :commentable, :polymorphic => true
  has_many :comments, :as => :commentable

end
