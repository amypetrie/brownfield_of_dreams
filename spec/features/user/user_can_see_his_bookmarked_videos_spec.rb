require 'rails_helper'

describe "A registered user" do
  it "can see bookmarked videos" do
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial_1.id)
    video_2 = create(:video, tutorial_id: tutorial_1.id)
    video_3 = create(:video, tutorial_id: tutorial_2.id)
    video_4 = create(:video, tutorial_id: tutorial_2.id)

    user = create(:user)
    user.videos << [video_1, video_2, video_3]
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # As a logged in user
    # When I visit my dashboard
    visit dashboard_path

    expect(page).to have_content("Bookmarked Segments")
    expect(page).to have_css('.video_link', count: 3)
    expect(page).to have_css('.tutorial', count: 2)
  end
end