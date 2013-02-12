class AddSubtractionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Subtraction, :integer
  end
end
