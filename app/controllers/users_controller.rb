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
    #@user.currentpicks.new
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
    logger.debug("user update>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    #logger.debug(@user.problemselectedstring)
    @user = User.find(params[:id])

    if (params[:change_infile] || params[:delete_problem_button]|| params[:add_delete_infile]|| params[:first_button]|| params[:second_button]|| params[:fourth_button]|| params[:add_problem_button]|| params[:new_file])|| params[:third_button]|| params[:delete_infile]


      respond_to do |format|
        if @user.update_attributes(params[:user])
          flash.notice = 'Update sucessful.'
          format.html { redirect_to generate_path  }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

    else

     
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
    #@user.infiles.build
    if @user.fileselected && @user.fileselected.length > 0 && FileTest.exists?(Rails.root.join('public','json',@user.fileselected))

      @problemlist = File.read(Rails.root.join('public','json',@user.fileselected))
      @problemlisthash = JSON.parse(@problemlist)
      #logger.debug(@problemlisthash)
      @problems = @problemlisthash ["problem-list"]
    end

    if params[:change_infile]
      logger.debug(">>>>>>>>>>>>>>>>>")
      @user.fileselected = params[:change_infile]
      params.delete(:change_infile)
      #params.save
      logger.debug(params.inspect)
      @user.problemselectedstring = ""
      @user.save
    end

    if params[:delete_infile]
      logger.debug("delete file action>>>>>>>>")
      current_user.infiles.each do |infile|
        logger.debug(infile.infile_file_name)
        logger.debug(@user.fileselected)
        if infile.infile_file_name == @user.fileselected
          logger.debug ("deleting file")
          infile.destroy
        end
      end
    end

    if params[:new_file]
      if @user.newfilename.length > 0

        @newproblem = {"start"=>"new", "options"=>[], "value"=>{"accuracy-coins"=>3, "min-errors"=>1, "max-errors"=>6, "speed-coins"=>3, "min-speed"=>1.0, "max-speed"=>15.0}}
        @newproblemarray = []

        #@problems.each_with_index do |i, index|
          @newproblemarray << @newproblem
        #   if @problems[index]["start"] == @user.problemselectedstring
        #     @problemnumber = index
        #     @newproblemarray << @newproblem
        #     logger.debug ("index to add:")
        #     logger.debug (index)
        #   end
        # end

        # @user.infiles.build

        #@problems.add_at(@problemnumber)

        #@problems << @newproblem

        @user.problemselectedstring = "new"
        @user.fileselected = @user.newfilename


        @problems = {"problem-list" => @newproblemarray}
        @new_json = (@problems.to_json)

        @localfilename = (Rails.root.join('public','json',@user.newfilename))

        #@user.infile.new

        File.open(Rails.root.join('public','json',@user.newfilename),"w") do |f|
          f.write(@new_json)
          #@user.infiles = f
        end

        #@logger.debug(@user.infiles.infile)

        # File.open(Rails.root.join('public','json',@user.newfilename),"r") do |f|
        #   #f.write(@new_json)
        # #   @user.infiles.object.infile_file_name = f
        # # end
        # logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        # #User.new(:infiles => File.open('/Users/thad/railsProjects/interfaceInputTrial/public/json/hope2.json'), 'r')
        # @user = current_user
        current_user.infiles.build
        current_user.infiles.each do |infile|
            logger.debug("instance methods")
            logger.debug(infile.inspect)
           if !infile.infile_file_name 
        #       File.open(Rails.root.join('public','json',@user.newfilename),"r") do |f|
        #       File.open(Rails.root.join('public','json',@user.newfilename),"r") do |f|
        #       #   #f.write(@new_json)
                infile.infile_file_name = @user.newfilename
                infile.user_id = @user.id
                infile.save
               end
             end
        #   end


      #end
        #@user.infile = @localfilename
        #@user.save
        @user.newfilename = ""
        @user.save

      end # of if filename valid

    end # of if new file

    # if params[:second_button]

    #   @problems.each_with_index do |i, index|
    #     if @problems[index]["start"] == @user.problemselectedstring
    #       @problemnumber = index
    #       logger.debug ("index to modify:")
    #       logger.debug (index)
    #     end
    #   end

    #   @problems[@problemnumber]["start"] = @user.problemchange
    #   @user.problemselectedstring = @user.problemchange

    #   @user.save

    #   @problems = {"problem-list" => @problems}
    #   @new_json = (@problems.to_json)

    #   File.open(Rails.root.join('public','json',@user.fileselected),"w") do |f|
    #     f.write(@new_json)
    #   end

    # end # of if second_button


      #  logger.debug ("found it.")
      #  
      # #     logger.debug(@user.problemchange)
      # #     logger.debug(@user.problemselectedstring)
      #logger.debug("getting there.............")
      #   if @user.problemchange != @user.problemselectedstring
      #   #       @problems = {"problem-list" => @problems }
      #logger.debug("Here are the problems")
      #logger.debug (@problems)
      #   @new_json = (@problems.to_json)
      #   File.open(Rails.root.join('public','json',@user.fileselected),"w") do |f|
      #     f.write(@problems.to_json)
    
    # if we have a problem selected
    #if @user.problemchange.length > 1
      # @problems[@problemnumber]["start"] = @user.problemchange
      # @user.problemselectedstring = @user.problemchange
      # logger.debug("problemselectedstring")
      # logger.debug(@user.problemselectedstring)

      # @problems_list = {"problem-list" => @problems}
      #logger.debug ("problem list")
      #logger.debug (@problems_list)

      # @new_json = (@problems_list.to_json)
      # logger.debug(@new_json)
      
      # File.open(Rails.root.join('public','json',@user.fileselected),"w") do |f|
      #   f.write(@new_json)
      # end
    
      #@user.save

    #end  

    #logger.debug(params)
    # end
    #@user.active = true
    #@user.save
    #end

    # if params[:third_button]
    #   @problems.each_with_index do |i, index|
    #     if @problems[index]["start"] == @user.problemselectedstring
    #       @problemnumber = index
    #       logger.debug ("index to modify:")
    #       logger.debug (index)
    #     end
    #   end
   
    #   logger.debug("modifying options.............")

    #   @optionshash = []

    #   if @user.ExactCompleteMatch == 1
    #     @optionshash << "exactCompleteMatch"
    #   end
    #   if @user.ManualArithmetic == 1
    #     @optionshash << "manualArithmetic"
    #   end
    #   if @user.QuickElimination == 1
    #     @optionshash << "quickElimination"
    #   end
    #   if @user.ManualDone == 1
    #     @optionshash << "manualDone"
    #   end
    #   if @user.Editable == 1
    #     @optionshash << "editable"
    #   end
    #   if @user.ManualFactoring == 1
    #     @optionshash << "manualFactoring"
    #   end
    #   if @user.ManualTranspose == 1
    #     @optionshash << "manualTranspose"
    #   end
    #   if @user.ProblemScrolling == 1
    #     @optionshash << "problemScrolling"
    #   end
    #   if @user.TapToFactorize == 1
    #     @optionshash << "tapToFactorize"
    #   end
    #   if @user.MoveComplex == 1
    #     @optionshash << "noMoveComplex"
    #   end
    #   if @user.PlusSpacing == 1
    #     @optionshash << "noFactorize"
    #   end
    #   if @user.TimesSpacing == 1
    #     @optionshash << "timesSpacing"
    #   end
    #   if @user.EqualsSpacing == 1
    #     @optionshash << "equalsSpacing"
    #   end
    #   if @user.Subtraction == 1
    #     @optionshash << "subtraction"
    #   end
    #   if @user.GameTimeOut == 1
    #     @optionshash << "gameTimeOut"
    #   end
    #   #if @use
    #   #if @user.problemchange.length > 1
    #   @problems[@problemnumber]["options"] = @optionshash
    #   #@user.problemselectedstring = @user.problemchange
    #   #logger.debug(@optionshash)
    #   #logger.debug("That was options hash")

    #   @problems_list = {"problem-list" => @problems}
    #   #logger.debug (@problems_list)

    #   @new_json = (@problems_list.to_json)

    #   #logger.debug(@new_json)
    #   File.open(Rails.root.join('public','json',@user.fileselected),"w") do |f|
    #     f.write(@new_json)
    #   end
    #   #@user.save
    #   #end
    #   #logger.debug(params)

    # end # of if third button

    if params[:fourth_button]

      #@problems.delete_at(4)

      @problems.each_with_index do |i, index|
            
        if @problems[index]["start"] == @user.problemselectedstring
          @problemnumber = index
          logger.debug ("index to modify:")
          logger.debug (index)
        end
      end

      @newvaluehash = {"accuracy-coins" => @user.accuracycoins, "min-errors" => @user.minerrors, "max-errors" => @user.maxerrors, "speed-coins" => @user.speedcoins, "min-speed" => @user.minspeed, "max-speed" => @user.maxspeed }

      @problems[@problemnumber]["value"] = @newvaluehash
      
      @problemstowrite = {"problem-list" => @problems}
      @new_json = (@problemstowrite.to_json)

      File.open(Rails.root.join('public','json',@user.fileselected),"w") do |f|
        f.write(@new_json)
      end

      #if params[:second_button]

      @problems.each_with_index do |i, index|
        if @problems[index]["start"] == @user.problemselectedstring
          @problemnumber = index
          logger.debug ("index to modify:")
          logger.debug (index)
        end
      end

      @problems[@problemnumber]["start"] = @user.problemchange
      @user.problemselectedstring = @user.problemchange

      @user.save

      @problemstowrite = {"problem-list" => @problems}
      @new_json = (@problemstowrite.to_json)

      File.open(Rails.root.join('public','json',@user.fileselected),"w") do |f|
        f.write(@new_json)
      end

      #end # of if second_button
      #if params[:third_button]
      @problems.each_with_index do |i, index|
        if @problems[index]["start"] == @user.problemselectedstring
          @problemnumber = index
          logger.debug ("index to modify:")
          logger.debug (index)
        end
      end
   
      logger.debug("modifying options.............")

      @optionshash = []

      if @user.ExactCompleteMatch == 1
        @optionshash << "exactCompleteMatch"
      end
      if @user.ManualArithmetic == 1
        @optionshash << "manualArithmetic"
      end
      if @user.QuickElimination == 1
        @optionshash << "quickElimination"
      end
      if @user.ManualDone == 1
        @optionshash << "manualDone"
      end
      if @user.Editable == 1
        @optionshash << "editable"
      end
      if @user.ManualFactoring == 1
        @optionshash << "manualFactoring"
      end
      if @user.ManualTranspose == 1
        @optionshash << "manualTranspose"
      end
      if @user.ProblemScrolling == 1
        @optionshash << "problemScrolling"
      end
      if @user.TapToFactorize == 1
        @optionshash << "tapToFactorize"
      end
      if @user.MoveComplex == 1
        @optionshash << "noMoveComplex"
      end
      if @user.PlusSpacing == 1
        @optionshash << "noFactorize"
      end
      if @user.TimesSpacing == 1
        @optionshash << "timesSpacing"
      end
      if @user.EqualsSpacing == 1
        @optionshash << "equalsSpacing"
      end
      if @user.Subtraction == 1
        @optionshash << "subtraction"
      end
      if @user.GameTimeOut == 1
        @optionshash << "gameTimeOut"
      end
      #if @use
      #if @user.problemchange.length > 1
      @problems[@problemnumber]["options"] = @optionshash
      #@user.problemselectedstring = @user.problemchange
      #logger.debug(@optionshash)
      #logger.debug("That was options hash")

      @problems_list = {"problem-list" => @problems}
      #logger.debug (@problems_list)

      @new_json = (@problems_list.to_json)

      #logger.debug(@new_json)
      File.open(Rails.root.join('public','json',@user.fileselected),"w") do |f|
        f.write(@new_json)
      end
      #@user.save
      #end
      #logger.debug(params)

    #end # of if third button


    end # of if fourth_button

    if params[:delete_problem_button]
      @problems.each_with_index do |i, index|
        if @problems[index]["start"] == @user.problemselectedstring
          @problemnumber = index
          logger.debug ("index to delete:")
          logger.debug (index)
        end
      end

      @problems.delete_at(@problemnumber)
      @user.problemselectedstring = ''
      @user.save

      @problems = {"problem-list" => @problems}
      @new_json = (@problems.to_json)

      File.open(Rails.root.join('public','json',@user.fileselected),"w") do |f|
        f.write(@new_json)
      end

    end # of if delete_problem_button

    if params[:add_problem_button]

      @newproblem = {"start"=>"new", "options"=>[], "value"=>{"accuracy-coins"=>3, "min-errors"=>1, "max-errors"=>6, "speed-coins"=>3, "min-speed"=>1.0, "max-speed"=>15.0}}
      @newproblemarray = []

      @problems.each_with_index do |i, index|
        @newproblemarray << @problems[index]
        if @problems[index]["start"] == @user.problemselectedstring
          @problemnumber = index
          @newproblemarray << @newproblem
          logger.debug ("index to add:")
          logger.debug (index)
        end
      end


      #@problems.add_at(@problemnumber)

      #@problems << @newproblem

      @user.problemselectedstring = "new"
      @user.save

      @problems = {"problem-list" => @newproblemarray}
      @new_json = (@problems.to_json)

      File.open(Rails.root.join('public','json',@user.fileselected),"w") do |f|
        f.write(@new_json)
      end

    end # of if add_problem_button

   
  end # of update


#end

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
