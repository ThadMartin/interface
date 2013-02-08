class CreateInfiles < ActiveRecord::Migration
  def change
    create_table :infiles do |t|
      t.string :infile_file_name
      t.string :infile_content_type
      t.integer :infile_file_size
      t.datetime :infile_updated_at
      t.integer :user_id

      t.timestamps
    end
  end
end
