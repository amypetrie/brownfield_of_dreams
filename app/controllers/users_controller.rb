class UsersController < ApplicationController

  def show
    @facade = UserDashboardFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      RegistrationMailer.register(user).deliver_now
      session[:user_id] = user.id
      flash[:notice] = "Logged in as #{user.first_name} #{user.last_name}"
      flash[:error] = "This account has not yet been activated. Please check your email."
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
