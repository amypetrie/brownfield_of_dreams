require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end

# If a tutorial doesn't have any videos and we visit its show page an error occurs when trying to call current_video.title since current_video is nil.

  it 'vistor clicks on a tutorial title with no associated videos' do
    tutorial = create(:tutorial)
    # video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title
    save_and_open_page

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content("No Videos Yet")
  end
end
