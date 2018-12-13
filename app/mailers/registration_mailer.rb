class RegistrationMailer < ApplicationMailer

  def register(user)
    @email = user.email
    mail(to: @email, subject: "Register Now!")
  end

end
