class UserMailer < ActionMailer::Base

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
       @url  = "#{SITE_URL}/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @url  = "#{SITE_URL}/login"
  end
  
  
  
  def reset_notification(user)  
    setup_email(user)  
    @subject    += 'Link to reset your password'  
    @body[:url]  = "#{SITE_URL}/reset/#{user.reset_code}"  
  end    
  
  
  protected

  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "admin@PrivateSpace"
    @subject     = "[PrivateSpace] "
    @sent_on     = Time.now
    @user = user
  end

end
