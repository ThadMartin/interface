class AddTapToFactorizeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :TapToFactorize, :integer
  end
end
