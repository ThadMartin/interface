class AddPlusSpacingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :PlusSpacing, :integer
  end
end
