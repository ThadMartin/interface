class CreateCurrentpicks < ActiveRecord::Migration
  def change
    create_table :currentpicks do |t|
      t.string :fileselected
      t.integer :proplemselected

      t.timestamps
    end
  end
end
