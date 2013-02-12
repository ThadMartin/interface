class AddMaxerrorsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :maxerrors, :integer
  end
end
