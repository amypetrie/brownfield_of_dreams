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
  end

end
