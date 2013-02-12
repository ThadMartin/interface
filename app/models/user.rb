class User < ActiveRecord::Base
  #acts_as_authentic
  acts_as_authentic do |c| c.login_field = :email end
  attr_accessible :username, :email, :password, :password_confirmation, :infiles, :infiles_attributes, :fileselected, :problemselectedstring, :problemchange, :ExactCompleteMatch, :ManualArithmetic, :QuickElimination, :ManualDone, :Editable, :ManualFactoring, :ManualTranspose, :ProblemScrolling, :TapToFactorize, :MoveComplex, :PlusSpacing, :TimesSpacing, :EqualsSpacing, :Subtraction, :GameTimeOut, :accuracycoins, :minerrors, :maxerrors, :speedcoins, :minspeed, :maxspeed, :newfilename, :infile

  has_many :infiles
  has_one :currentpicks
  accepts_nested_attributes_for :infiles, :allow_destroy => true
end
