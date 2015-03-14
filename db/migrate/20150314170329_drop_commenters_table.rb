class DropCommentersTable < ActiveRecord::Migration
  def up
    drop_table :commenters
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
