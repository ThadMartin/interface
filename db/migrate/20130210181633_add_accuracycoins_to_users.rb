class AddAccuracycoinsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accuracycoins, :integer
  end
end
