class AddFileselectedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fileselected, :string
  end
end
