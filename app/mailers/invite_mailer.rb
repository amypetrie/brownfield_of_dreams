class InviteMailer < ApplicationMailer

  def invite(user, contact)
    @user = user
    @contact = contact
    mail(to: contact, subject: "Join our site!")
  end

end
