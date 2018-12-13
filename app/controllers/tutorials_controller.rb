class TutorialsController < ApplicationController

  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.public_tutorial || current_user
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

end
