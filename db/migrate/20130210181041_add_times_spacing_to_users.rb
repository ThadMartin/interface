class AddTimesSpacingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :TimesSpacing, :integer
  end
end
