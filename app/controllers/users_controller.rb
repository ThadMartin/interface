class UsersController < ApplicationController

  before_filter :require_same_user, :except => [:index, :new, :create]
  #before_filter :require_user

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    logger.debug("user index")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    logger.debug("user show")
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    logger.debug("user new")
    @user = User.new
    #@user.infiles.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    logger.debug("user edit")
    @user = User.find(params[:id])
    @user.infiles.build
  end

  # POST /users
  # POST /users.json
  def create
    logger.debug("user create")
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to home_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    logger.debug("user update")
    @user = User.find(params[:id])
    #@user.infiles.build
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash.notice = 'Update sucessful.'
        format.html { redirect_to home_path  }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    logger.debug("user destroy")
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # def add_infile
  #   logger.debug ("added infile?????????????????????????????")
  #   @user = User.find(params[:id])
  #   @user.infiles.build
    
  # end
end
