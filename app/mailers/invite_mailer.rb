class InviteMailer < ApplicationMailer

  def invite(user, email)
    @user = user
    @email = email
    mail(to: email, subject: "Join our site!")
  end

end
