require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
    it {should have_many(:friendships)}
    it {should have_many(:friended_users)}
    it {should have_many(:friends)}
    it {should have_many(:friend_users)}
  end

  describe 'user friendships' do
    it 'user can have many friended users' do
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)

      Friendship.create(user: user_1, friended_user_id: user_2.id)
      Friendship.create(user: user_1, friended_user_id: user_3.id)

      expect(user_1.friended_users).to eq [user_2, user_3]
    end

    it 'user can have many friends' do
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)

      Friendship.create(user: user_2, friended_user_id: user_1.id)
      Friendship.create(user: user_3, friended_user_id: user_1.id)

      expect(user_1.friend_users).to eq [user_2, user_3]
      expect(user_2.friended_users).to eq [user_1]
    end
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end
end
