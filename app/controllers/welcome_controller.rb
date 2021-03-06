class WelcomeController < ApplicationController
  def index
    if params[:tag] && current_user
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    elsif params[:tag] && !current_user
      @tutorials = Tutorial.public_tutorials.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page =>5)
    elsif current_user
      @tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5)
    else
      @tutorials = Tutorial.public_tutorials.paginate(:page => params[:page], :per_page => 5)
    end
  end
end
