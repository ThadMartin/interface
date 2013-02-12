class AddQuickEliminationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :QuickElimination, :integer
  end
end
