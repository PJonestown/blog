class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.string :title
      t.string :body
      t.references :admin, index: true

      t.timestamps null: false
    end
    add_foreign_key :drafts, :admins
  end
end
