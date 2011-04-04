class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
    debugger
    @user = User.new
  end
 
  def create
    
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_back_or_default('/', :notice => "Thanks for signing up!  We're sending you an email with your activation code.")
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      redirect_to '/login', :notice => "Signup complete! Please sign in to continue."
    when params[:activation_code].blank?
      redirect_back_or_default('/', :flash => { :error => "The activation code was missing.  Please follow the URL from your email." })
    else 
      redirect_back_or_default('/', :flash => { :error  => "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in." })
    end
  end


  
 def forgot  
  if request.post?  
    user = User.find_by_email(params[:user][:email])  
  logger.info("你想輸出的字串")

  
    respond_to do |format|  
      if user  
        user.create_reset_code  
        flash[:notice] = "---Reset code sent to #{user.email}"  

        format.html { redirect_to login_path }  
  #     format.xml { render :xml => '<img src="http://net.tutsplus.com/wp-includes/images/smilies/icon_mad.gif" alt=":x" class="wp-smiley">' , :ml => user.email, :status => :unprocessable_entity }  
      else  
        flash[:error] = "#{params[:user][:email]} does not exist in system"  
  
  
  
        format.html { redirect_to login_path }  
  #      format.xml { render :xml => '<img src="http://net.tutsplus.com/wp-includes/images/smilies/icon_mad.gif" alt=":x" class="wp-smiley">' , :ml => user.email, :status => :unprocessable_entity }  
      end  
    end  
 end
 end
  
  
def reset  
  @user = User.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?  
  if request.post?  
    if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])  
      self.current_user = @user  
      @user.delete_reset_code  
      flash[:notice] = "Password reset successfully for #{@user.email}"  
      redirect_to login_path  
    else  
      render :action => :reset  
    end  
  end  
end    


def index
  #I18n.locale = :en

  #@temp_user = User.find(2) 
end

end
