class AddManualArithmeticToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ManualArithmetic, :integer
  end
end
