class Infile < ActiveRecord::Base
  attr_accessible :infile, :infile_content_type, :infile_file_name, :infile_file_size, :infile_updated_at, :user_id, :user #:infiles, 
  belongs_to :user
  has_attached_file :infile, :path => ":rails_root/public/json/:basename.:extension"
end
