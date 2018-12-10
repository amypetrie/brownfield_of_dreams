class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friended_user, class_name: 'User'
  # 
  # def initialize(user, friended_user)
  #   @user = user
  #   @friended_user = friended_user
  # end

end
