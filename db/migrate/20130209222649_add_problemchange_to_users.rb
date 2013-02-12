class AddProblemchangeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :problemchange, :string
  end
end
