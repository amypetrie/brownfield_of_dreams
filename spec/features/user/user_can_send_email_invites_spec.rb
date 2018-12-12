require 'rails_helper'

describe 'A registered user' do
#   As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite
  it 'clicks Send an Invite to go the invite page' do
    user = create(:user)
    visit dashboard_path
    click_on "Send an Invite"
    expect(current_path)to eq new_invite_[path]
  end
end
