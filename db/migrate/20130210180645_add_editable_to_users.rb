class AddEditableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Editable, :integer
  end
end
