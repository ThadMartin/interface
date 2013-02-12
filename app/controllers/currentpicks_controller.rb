class CurrentpicksController < ApplicationController
  # GET /currentpicks
  # GET /currentpicks.json
  def index
    logger.debug("currentpick index")
    @currentpicks = Currentpick.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @currentpicks }
    end
  end

  # GET /currentpicks/1
  # GET /currentpicks/1.json
  def show
    logger.debug("currentpick show")
    @currentpick = Currentpick.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @currentpick }
    end
  end

  # GET /currentpicks/new
  # GET /currentpicks/new.json
  def new
    logger.debug("currentpick new")
    @currentpick = Currentpick.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @currentpick }
    end
  end

  # GET /currentpicks/1/edit
  def edit
    logger.debug("currentpick edit")
    @currentpick = Currentpick.find(params[:id])
  end

  # POST /currentpicks
  # POST /currentpicks.json
  def create
    logger.debug("currentpick create")
    @currentpick = Currentpick.new(params[:currentpick])

    respond_to do |format|
      if @currentpick.save
        format.html { redirect_to @currentpick, notice: 'Currentpick was successfully created.' }
        format.json { render json: @currentpick, status: :created, location: @currentpick }
      else
        format.html { render action: "new" }
        format.json { render json: @currentpick.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /currentpicks/1
  # PUT /currentpicks/1.json
  # def update
  #   logger.debug("currentpick index")
  #   @currentpick = Currentpick.find(params[:id])

  #   respond_to do |format|
  #     if @currentpick.update_attributes(params[:currentpick])
  #       format.html { redirect_to @currentpick, notice: 'Currentpick was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @currentpick.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
def update
    logger.debug("user update>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    #logger.debug(@user.problemselectedstring)
    @user = current_user
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
    #@user.infiles.build
    @problemlist = File.read(Rails.root.join('public','json',@user.fileselected))
    @problemlisthash = JSON.parse(@problemlist)
    logger.debug(@problemlisthash)
    @problems = @problemlisthash ["problem-list"]

    if params[:change_infile]
      @user.problemselectedstring = ""
      @user.save
    end

    if params[:second_button]

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

      @problems = {"problem-list" => @problems}
      @new_json = (@problems.to_json)

      File.open(Rails.root.join('public','json',@user.fileselected),"w") do |f|
        f.write(@new_json)
      end

    end # of if second_button


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

    if params[:third_button]
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
        @optionshash << "moveComplex"
      end
      if @user.PlusSpacing == 1
        @optionshash << "plusSpacing"
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
      logger.debug(@optionshash)
      logger.debug("That was options hash")

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

    end # of if third button

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
      
      @problems = {"problem-list" => @problems}
      @new_json = (@problems.to_json)

      File.open(Rails.root.join('public','json',@user.fileselected),"w") do |f|
        f.write(@new_json)
      end



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

  # DELETE /currentpicks/1
  # DELETE /currentpicks/1.json
  def destroy
    logger.debug("currentpick index")
    @currentpick = Currentpick.find(params[:id])
    @currentpick.destroy

    respond_to do |format|
      format.html { redirect_to currentpicks_url }
      format.json { head :no_content }
    end
  end
end
