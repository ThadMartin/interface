class AddManualFactoringToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ManualFactoring, :integer
  end
end
