class RemoveCommenterIdFromComments < ActiveRecord::Migration
  def change
    remove_reference :comments, :commenter
  end
end
