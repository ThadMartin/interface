class AddFileselectedToInfiles < ActiveRecord::Migration
  def change
    add_column :infiles, :fileselected, :string
  end
end
