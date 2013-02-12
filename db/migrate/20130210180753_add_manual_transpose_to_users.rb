class AddManualTransposeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ManualTranspose, :integer
  end
end
