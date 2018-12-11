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

  it 'different users see different repos' do
    user_1 = create(:user, token: "JIMMYS TOKEN", first_name: "Amy")
    user_2 = create(:user, first_name: "Bryant")
    # Make sure this shows the proper repositories when there are more than one user in the database with different tokens.

    stub_request(:get, "https://api.github.com/user/repos").
      with(headers: {"Authorization" => "token #{user_1.token}"}).
        to_return(body: File.read("./spec/fixtures/user_repos_2.json"))

        stub_request(:get, "https://api.github.com/user/followers").
          with(headers: {"Authorization" => "token #{user_1.token}"}).
            to_return(body: File.read("./spec/fixtures/followers.json"))

            stub_request(:get, "https://api.github.com/user/following").
              with(headers: {"Authorization" => "token #{user_1.token}"}).
                to_return(body: File.read("./spec/fixtures/user_following.json"))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path

    expect(page).to have_content("museo")
  end

  # I should see another section titled "Followers"
  it 'should see a section titled Followers' do

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Followers")
  end

  # And I should see list of all followers with their handles linking to their Github profile
  it 'should see a list of followers with handles linking to github profiles' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path


    expect(page).to have_css(".follower", count: 5)

    # And under that section I should see a list of 5 repositories
    within(first(".follower")) do
      expect(page).to have_link("averimj")
   #put in actual data
    # with the name of each Repo linking to the repo on Github
    end
  end

  # And under that section I should see another section titled "Following"
  it 'should see a section titled Following' do
    stub_request(:get, "https://api.github.com/user/following").
        to_return(body: File.read("./spec/fixtures/user_following.json"))

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Following")
  end

# And I should see list of users I follow with their handles linking to their Github profile
  it 'should see a list of people user is following with handles linking to github profiles' do
    stub_request(:get, "https://api.github.com/user/following").
        to_return(body: File.read("./spec/fixtures/user_following.json"))

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path

    expect(page).to have_css(".following_section", count: 1)

    within(first(".followed_user")) do
      expect(page).to have_link("lnchambers")
    end
  end

  it 'should see Add Friend link if follower exists in the DB' do
    user = create(:user)
    user_2 = create(:user, uid: "33760591")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path

    within(first(".follower")) do
      expect(page).to have_button("Add as Friend")
    end
  end

  it 'should see Add Friend link if follow user exists in the DB' do
    user = create(:user)
    user_2 = create(:user, uid: "32661560")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path

    within(first(".followed_user")) do
      expect(page).to have_button "Add as Friend"
    end
  end

  it 'clicks Add Friend to add friend' do
    user = create(:user)
    user_2 = create(:user, uid: "32661560")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within(first(".followed_user")) do
      click_on("Add as Friend")
      expect(current_path).to eq dashboard_path
    end

    expect(page).to have_content "Friend added!"
  end

  it 'sees added friends under My Friends' do
    user_1 = create(:user, uid: "123", first_name: "Amy")
    user_2 = create(:user, uid: "33760591", first_name: "Rachel")
    user_3 = create(:user, uid: "32661560", first_name: "Abby")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path

    within(".following_section") do
      click_on("Add as Friend")
    end

    user_new = User.find(user_1.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_new)

    expect(page).to have_content user_3.first_name
  end

end
