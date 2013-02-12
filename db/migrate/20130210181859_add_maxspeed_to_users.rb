class AddMaxspeedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :maxspeed, :real
  end
end
