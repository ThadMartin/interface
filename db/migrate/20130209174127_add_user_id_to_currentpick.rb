class AddUserIdToCurrentpick < ActiveRecord::Migration
  def change
    add_column :currentpicks, :user_id, :integer
  end
end
