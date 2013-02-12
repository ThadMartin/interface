class AddProblemselectedToInfiles < ActiveRecord::Migration
  def change
    add_column :infiles, :problemselected, :integer
  end
end
