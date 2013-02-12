class AddGameTimeOutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :GameTimeOut, :integer
  end
end
