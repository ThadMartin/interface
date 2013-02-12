class Currentpick < ActiveRecord::Base
  attr_accessible :fileselected, :proplemselected, :currentpicks
  belongs_to :user
end
