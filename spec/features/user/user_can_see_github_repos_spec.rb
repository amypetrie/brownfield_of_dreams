require 'rails_helper'

feature 'A logged in user can see github repos' do
  it "can visit the dasbbaord" do

    stub_request(:get, "https://api.github.com/user/repos").
        to_return(body: File.read("./spec/fixtures/user_repos.json"))

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    save_and_open_page

    # Then I should see a section for "Github"
    expect(page).to have_content("Github")
    expect(page).to have_css(".github_repo", count: 5)

    # And under that section I should see a list of 5 repositories
      within(first(".github_repo")) do
        expect(page).to have_link("2win_playlist") #put in actual data
        # with the name of each Repo linking to the repo on Github
        click_link ("Repo_name")
        expect(current_path).to eq "xyz"
      end
  end
end
