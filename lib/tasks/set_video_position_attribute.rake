namespace :videos do
  desc "Sets position attributes to not nil"
  task :set_position => [ :environment ] do
    Video.where(position: nil).group_by(&:tutorial_id).each do |tutorial_id, videos|
      videos.sort_by(&:id).each_with_index do |video, i|
        binding.pry
        video.update(position: i + 1)
      end
    end
  end 
end 

# videos.sort_by(&:id) == videos.sort_by { |video| video.id }
