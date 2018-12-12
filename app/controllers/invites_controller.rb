class InvitesController < ApplicationController

  def new
  end

  def create
    InviteMailer.invite(current_user, params[:contact]).deliver_now
    if params[:contact][:email]
      flash[:notice] = "Successfully sent invite!"
      redirect_to dashboard_path
    else
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
      redirect_to dashboard_path
    end
  end

end
