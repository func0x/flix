class Rollback < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :username
  end
end
