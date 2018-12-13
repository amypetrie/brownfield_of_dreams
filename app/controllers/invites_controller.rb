class InvitesController < ApplicationController

  def new
  end

  def create
    email = GithubService.new(service_params).get_user_email
    if email != nil
      InviteMailer.invite(current_user, email).deliver_now
      flash[:notice] = "Successfully sent invite!"
      redirect_to dashboard_path
    else
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
      redirect_to dashboard_path
    end
  end

  def service_params
    params.permit(:github_handle)
  end

end
