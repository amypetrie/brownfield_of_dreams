class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friended_users, through: :friendships

  # has_many :followings
  # has_many :followed_users, through: :followings

  # has_many :followers, foreign_key: :followed_user_id, class_name: 'Following'
  # has_many :follower_users, through: :followers, source: :user

  has_many :friends, foreign_key: :friended_user_id, class_name: 'Friendship'
  has_many :friend_users, through: :friends, source: :user

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

end
