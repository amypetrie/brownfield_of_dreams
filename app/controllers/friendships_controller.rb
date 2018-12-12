class FriendshipsController < ApplicationController
  
  def new
  end

  def create
    @friendship = current_user.friendships.create(friended_user_id: friendship_params[:friended_user])
    if @friendship.save
      flash[:notice] = "Friend added!"
      redirect_to dashboard_path
    else
      flash[:error] = "Friend unable to be added!"
      redirect_to dashboard_path
    end
  end

private

  def friendship_params
    params.permit(:friended_user)
  end


end