require 'rails_helper'

describe "A registered user" do
 it "can see github repos" do
  stub_request(:get, "https://api.github.com/user/repos").
        to_return(body: File.read("./spec/fixtures/user_repos.json"))

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # As a logged in user
    # When I visit my dashboard
    visit dashboard_path

    # Then I should see a section for "Github"
    expect(page).to have_content("Github")
    expect(page).to have_css(".github_repo", count: 5)

    # And under that section I should see a list of 5 repositories
    within(first(".github_repo")) do
      expect(page).to have_link("2win_playlist") #put in actual data
    # with the name of each Repo linking to the repo on Github
    end
  end

  it 'doesnt see github section if no token' do
    user = create(:user, token: nil)
    # Don't display the "Github" section if the user is missing a Github token

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path

    expect(page).to_not have_content("Github")
  end

  xit 'different users see different repos' do
    user_1 = create(:user, token: "abc", first_name: "Amy")
    user_2 = create(:user, first_name: "Bryant")
    # Make sure this shows the proper repositories when there are more than one user in the database with different tokens.

    stub_request(:get, "https://api.github.com/user/repos").
      with(headers: {"Authorization" => "#{user_1.token}"}).
        to_return(body: File.read("./spec/fixtures/user_repos_2.json"))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit dashboard_path
    save_and_open_page

    expect(page).to have_content("2win_playlist")
  end
end
