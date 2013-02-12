class AddProblemScrollingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ProblemScrolling, :integer
  end
end
