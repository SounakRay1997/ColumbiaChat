class UserMailer < ActionMailer::Base
  default :from => "columbiachat@gmail.com"
  layout 'mailer'
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registration Confirmation")
  end
end