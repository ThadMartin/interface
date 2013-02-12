class AddEqualsSpacingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :EqualsSpacing, :integer
  end
end
