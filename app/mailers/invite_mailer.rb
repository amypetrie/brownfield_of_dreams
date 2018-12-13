class InviteMailer < ApplicationMailer

  def invite(user, recipient)
    @user = user
    @email = recipient[:email]
    @name = recipient[:name]
    mail(to: @email, subject: "Join our site!")
  end

end
