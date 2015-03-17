class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :commentable_id
      t.string :commentable_type
      t.references :commenter, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :commenters
  end
end
