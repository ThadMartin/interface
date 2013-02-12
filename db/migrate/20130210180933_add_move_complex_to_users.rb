class AddMoveComplexToUsers < ActiveRecord::Migration
  def change
    add_column :users, :MoveComplex, :integer
  end
end
