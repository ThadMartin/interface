class AddProblemselectedThreeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :problemselectedstring, :string
  end
end
