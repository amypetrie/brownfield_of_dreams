class FriendshipsController < ApplicationController

  def new
  end

  def create
    current_user = User.find(params[:user_id])
    friend = User.find_by(uid: params[:friended_user])
    friendship = Friendship.create({user: current_user, friended_user: friend})
    if friendship.save
      flash[:notice] = "Friend added!"
      redirect_to dashboard_path
    else
      flash[:error] = "Friend unable to be added!"
      redirect_to dashboard_path
    end
  end


end
