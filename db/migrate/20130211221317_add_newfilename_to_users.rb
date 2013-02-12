class AddNewfilenameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :newfilename, :string
  end
end
