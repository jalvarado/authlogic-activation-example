class ActivationsController < ApplicationController
  rescue_from Exception, :with => :user_already_active
  
  before_filter :require_no_user
  
  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?
  end

  def create
    @user = User.find(params[:id])
    
    raise Exception if @user.active?
    
    if @user.activate!(params)
      @user.deliver_activation_confirmation!
      redirect_to user_path(@user)
    else
      render :action => :new
    end
  end

  private
  def user_already_active
    redirect_to login_path, :notice => "User has already been activated.  Please login to access this site."
  end
  
  def expired_perishable_token(token)
    user = User.find_using_perishable_token(token)
    
    if user
      user.deliver_activation_instructions! 
      redirect_to root_url, :notice => "Your activation code has expired.  A new code has been emailed to you."
    else
      redirect_to root_url, :error => "Invalid activation token."
    end
  end

end
