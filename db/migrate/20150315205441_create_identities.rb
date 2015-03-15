class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :uid
      t.references :commenter, index: true

      t.timestamps null: false
    end
    add_foreign_key :identities, :commenters
  end
end
