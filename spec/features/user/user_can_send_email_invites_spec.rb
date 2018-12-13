require 'rails_helper'

describe 'A registered user' do
#   As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite
  it 'clicks Send an Invite to go the invite page' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_on "Send an Invite"
    expect(current_path).to eq new_invite_path
  end

  it 'fills in a valid github handle to send an invite' do

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_invite_path

    username = "amypetrie"
    fill_in "github_handle", with: username

    stub_request(:get, "https://api.github.com/users/#{username}").
        to_return(body: File.read("./spec/fixtures/user.json"))

    click_on "Send Invite"

    expect(current_path).to eq dashboard_path
    expect(page).to have_content "Successfully sent invite!"
  end

  it 'gets an error message when an invalid github handle is entered' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_invite_path

    fill_in "github_handle", with: ('a'..'z').to_a.shuffle[0,25].join
    click_on "Send Invite"

    expect(current_path).to eq dashboard_path
    expect(page).to have_content "The Github user you selected doesn't have an email address associated with their account."
  end

end
