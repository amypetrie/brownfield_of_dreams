require 'rails_helper'

describe "A registered user" do
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

  it 'should not Add Friend link if user doesnt exist in the DB' do
    user = create(:user)
    user_2 = create(:user)
    user_3 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path

    within(".friends_section") do
      expect(page).to_not have_css(".friends")
    end
  end

  it 'clicks Add to Friends and sees success flash message if successful' do
    user = create(:user)
    user_2 = create(:user, uid: "33760591", first_name: "Rachel")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_on("Add as Friend")
    user_new = User.find(user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_new)

    expect(page).to have_content "Friend added!"
  end

  it 'sees friends under My Friends' do
    user_1 = create(:user, first_name: "Amy")
    user_2 = create(:user, first_name: "Rachel")
    user_3 = create(:user, first_name: "Abby")

    Friendship.create(user: user_1, friended_user_id: user_2.id)
    Friendship.create(user: user_1, friended_user_id: user_3.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path

    within(".friends_section") do
      expect(page).to have_content(user_2.first_name)
      expect(page).to have_content(user_3.first_name)
    end
  end

  it 'can click Add to Friends button to add friend' do
    user_1 = create(:user, first_name: "Amy")
    user_2 = create(:user, uid: "33760591", first_name: "Rachel")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path

    click_button "Add as Friend"

    user_1_new = User.find(user_1.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1_new)

    visit dashboard_path

    expect(page).to have_content(user_2.first_name)
  end
end
