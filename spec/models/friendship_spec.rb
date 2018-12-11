require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    it {should belong_to(:user)}
    it {should belong_to(:friended_user)}
  end

  it 'exists' do
      user_1 = create(:user)
      user_2 = create(:user)

      friendship = Friendship.new(user: user_1, friended_user_id: user_2.id)

      expect(friendship).to be_a Friendship
  end

end
