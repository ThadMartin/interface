class AddManualDoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ManualDone, :integer
  end
end
