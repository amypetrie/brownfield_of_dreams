class TutorialFacade < SimpleDelegator
  def initialize(tutorial, video = nil)
    super(tutorial)
    @video = video
  end

  def current_video
    if @video
      videos.find(@video.id)
    elsif videos.length > 1
      videos.first
    else
      @current_video ||= Video.create
    end
  end

  def next_video
    videos[current_video_index + 1] || current_video
  end

  def play_next_video?
    !(current_video.position >= maximum_video_position)
  end

  private

  def current_video_index
    videos.index(current_video)
  end

  def maximum_video_position
    videos.max_by { |video| video.position }.position
  end
end
