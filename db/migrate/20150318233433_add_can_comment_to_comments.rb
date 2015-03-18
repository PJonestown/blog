class AddCanCommentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :owner_type, :string
    add_column :comments, :owner_id, :integer
  end
end
