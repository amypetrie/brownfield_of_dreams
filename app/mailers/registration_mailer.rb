class RegistrationMailer < ApplicationMailer

  def register(user)
    @user = user
    mail(to: @user.email, subject: "Register Now!")
  end

end
