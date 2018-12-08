class UsersController < ApplicationController

  def show
    # key = current_user.token
    @facade = UserDashboardFacade.new(current_user) # change this to take in current_user
  end

  def new
    @user = User.new
  end

  def update
    data = request.env["omniauth.auth"]
    current_user.update(token: data.credentials.token)
    redirect_to dashboard_path
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
