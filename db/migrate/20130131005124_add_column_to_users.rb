class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin_flag, :integer
  end
end
