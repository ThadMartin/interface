class User < ActiveRecord::Base
  #acts_as_authentic
  acts_as_authentic do |c| c.login_field = :email end
  attr_accessible :username, :email, :password, :password_confirmation, :infiles, :infiles_attributes
  has_many :infiles
  accepts_nested_attributes_for :infiles, :allow_destroy => true
end
