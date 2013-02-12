class AddMinspeedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :minspeed, :real
  end
end
