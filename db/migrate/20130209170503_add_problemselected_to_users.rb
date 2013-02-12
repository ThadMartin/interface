class AddProblemselectedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :problemselected, :integer
  end
end
