class RemoveAncestryFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :ancestry
  end
end
