class AddExactCompleteMatchToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ExactCompleteMatch, :integer
  end
end
