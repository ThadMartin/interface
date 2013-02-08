class PagesController < ApplicationController
	
  def home
  end

  def generate
    @user = current_user
    @user.infiles.build
    logger.debug (@user.infiles.inspect)
    @listOfInfiles = (@user.infiles.each)
    #@listOfInfiles2 = @listOfInfiles.select('input_file_name')
    #logger.debug (@listOfInfiles2)
    @picker = []

    @listOfInfiles.each do |i|
      @picker <<  i ["infile_file_name"]
    end
    logger.debug(@picker.inspect)
    #@picker = []
  	# end
  end

  def printLog
    logger.debug(@fnm)
  end


end
