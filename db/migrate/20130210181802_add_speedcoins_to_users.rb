class AddSpeedcoinsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :speedcoins, :integer
  end
end
