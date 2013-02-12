class InfilesController < ApplicationController
  def new
  	@infile = Infile.new
  end

  def refresh
  	#@pickedFile = (params[:fileselected])
    logger.debug(@pickedFile)
    logger.debug(params)
    logger.debug("Hey")
    redirect_to generate_path
  end
  def update
    logger.debug("infile update")
    #logger.debug(params)
    # @user = User.find(params[:id])
    # #@user.infiles.build
    # respond_to do |format|
    #   if @user.update_attributes(params[:user])
    #     flash.notice = 'Update sucessful.'
    #     format.html { redirect_to home_path  }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: "edit" }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    #end
  end
end
