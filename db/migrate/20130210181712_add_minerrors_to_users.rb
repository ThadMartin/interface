class AddMinerrorsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :minerrors, :integer
  end
end
