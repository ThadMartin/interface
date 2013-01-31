class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user, :current_user_session

  before_filter :require_user, :only => :destroy


  layout "application"
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    #logger.debug "ApplicationController::require_user"
    unless current_user #= current_user_session.user #.require_same_user
      #store_location
      flash.notice = "You don't have permission to do that."
      redirect_to home_path
      return false
    end
  end
end
