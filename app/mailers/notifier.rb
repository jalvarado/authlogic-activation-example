class Notifier < ActionMailer::Base
  default :from => "from@example.com"
  default_url_options[:host] = "127.0.0.1:3000"
  
  def activation_instructions(user)
    @account_activation_url = registration_url(user.perishable_token)
    mail(:to => user.email, :subject => "Activation Instructions")
  end
  
  def activation_confirmation(user)
    mail(:to => user.email, :subject => "Activation Confirmation")
  end
end
