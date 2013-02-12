  class PagesController < ApplicationController
  	
    def home
    end

    def generate
      @user = current_user
      @user.infiles.build
      #logger.debug (@user.infiles.inspect)
      @listOfInfiles = (@user.infiles.each)
        current_user.infiles.each do |infile|
          logger.debug("instance methods")
          logger.debug(infile.inspect)
        end

      #@user.save
      #@listOfInfiles2 = @listOfInfiles.select('input_file_name')
      #logger.debug (@listOfInfiles2)
      @picker = []

      @listOfInfiles.each do |i|
        @picker <<  i ["infile_file_name"]
      end
      #logger.debug(@picker.inspect)
      #@picker = []
    	# end

      #if params[:first_button]
      logger.debug(@user.fileselected)
      logger.debug("about to get problem list")

      if @user.fileselected && @user.fileselected.length > 0 && FileTest.exists?(Rails.root.join('public','json',@user.fileselected))

        @problemlist = File.read(Rails.root.join('public','json',@user.fileselected))
      end
      if @problemlist
        @problemlisthash = JSON.parse(@problemlist)
      end

      logger.debug(@problemlist)
      if @problemlisthash
        @problems = @problemlisthash ["problem-list"]
      end
      
      #logger.debug(@problems)
      #@problems[1]["start"] = "1+1+1+1"
      #@testval = @problems.select{|key, hash| hash["start"]=="-4+-2"}
      #logger.debug(@testval

      @picker2 = []

      if @problems

        @problems.each_with_index do |i, index|
          logger.debug ("indexes")
          logger.debug (i)
          logger.debug (index)
          @picker2 <<  i["start"]
          #   logger.debug("What's i")
          if @user.problemselectedstring.length > 1
            if i["start"] == @user.problemselectedstring
              @optionshash2 = i["options"]  #not really hash, it's an array.
              @valuehash = i["value"]
            end
          end
          #   logger.debug(index)
          #   #logger.debug(@user.problemselectedstring)
          #   #logger.debug(@problems[index]["start"])
        end  # end of get problems and options
      end  # of if problems

      logger.debug("params are .....................")
      logger.debug(params)
      @user.ExactCompleteMatch = 0
      @user.ManualArithmetic = 0
      @user.ManualArithmetic = 0
      @user.QuickElimination = 0
      @user.ManualDone = 0
      @user.Editable = 0
      @user.ManualFactoring = 0
      @user.ManualTranspose = 0
      @user.ProblemScrolling = 0
      @user.TapToFactorize = 0
      @user.MoveComplex = 0
      @user.PlusSpacing = 0
      @user.TimesSpacing = 0
      @user.EqualsSpacing = 0
      @user.Subtraction = 0
      @user.GameTimeOut = 0

      @user.accuracycoins = 0
      @user.minerrors = 0
      @user.maxerrors = 0
      @user.speedcoins = 0
      @user.minspeed = 0
      @user.maxspeed = 0


      if @optionshash2

        @optionshash2.each do |i|
          logger.debug("reading options as:")
          logger.debug(i)
          if i.downcase == "ExactCompleteMatch".downcase
            @user.ExactCompleteMatch = 1
          end
          if i.downcase == "ManualArithmetic".downcase
            @user.ManualArithmetic = 1
          end
          if i.downcase == "QuickElimination".downcase
            @user.QuickElimination = 1
          end
          if i.downcase == "ManualDone".downcase
            @user.ManualDone = 1
          end
          if i.downcase == "Editable".downcase
            @user.Editable = 1
          end
          if i.downcase == "ManualFactoring".downcase
            @user.ManualFactoring = 1
          end
          if i.downcase == "ManualTranspose".downcase
            @user.ManualTranspose = 1
          end
          if i.downcase == "ProblemScrolling".downcase
            @user.ProblemScrolling = 1
          end
          if i.downcase == "TapToFactorize".downcase
            @user.TapToFactorize = 1
          end
          if i.downcase == "noMoveComplex".downcase
            @user.MoveComplex = 1
          end
          if i.downcase == "noFactorize".downcase
            @user.PlusSpacing = 1
          end
          if i.downcase == "TimesSpacing".downcase
            @user.TimesSpacing = 1
          end
          if i.downcase == "EqualsSpacing".downcase
            @user.EqualsSpacing = 1
          end
          if i.downcase == "Subtraction".downcase
            @user.Subtraction = 1
          end
          if i.downcase == "GameTimeOut".downcase
            @user.GameTimeOut = 1
          end

        end  # end of loop through options

      end  #end of if there are options

      #@user.save

      if @valuehash
        @user.accuracycoins = @valuehash["accuracy-coins"]
        @user.minerrors = @valuehash["min-errors"]
        @user.maxerrors = @valuehash["max-errors"]
        @user.speedcoins = @valuehash["speed-coins"]
        @user.minspeed = @valuehash["min-speed"]
        @user.maxspeed = @valuehash["max-speed"]

      end # of if valuehash

  #end
  end


def save_infile
  @pickedFile = (params[:pickedFile])
  logger.debug(@pickedFile)
  logger.debug("Hey")
      #redirect_to generate_path
    end


  end
