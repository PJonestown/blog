class AddNameToCommenters < ActiveRecord::Migration
  def change
    add_column :commenters, :name, :string
  end
end
