class User < ActiveRecord::Base
  #acts_as_authentic
   acts_as_authentic do |c| c.login_field = :email end
  attr_accessible :username, :email, :password, :password_confirmation
end
