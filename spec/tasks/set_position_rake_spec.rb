require "rails_helper" 
require "rake"
Rake.application.rake_require 'tasks/set_video_position_attribute'
Rake::Task.define_task(:environment)
 
describe "videos:set_position" do 
  it "updates a videos position" do 
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial_1.id)
    video_2 = create(:video, tutorial_id: tutorial_1.id)
    video_3 = create(:video, tutorial_id: tutorial_2.id)
    Video.where(id: [video_1, video_2, video_3].map(&:id)).update_all(position: nil)
    Rake::Task["videos:set_position"].invoke

    expect([video_1, video_2, video_3].map(&:reload).map(&:position)).to eq([1, 2, 1])
  end 
end 
