class Comment < ActiveRecord::Base

  has_ancestry

  belongs_to :owner, :polymorphic => true

end
