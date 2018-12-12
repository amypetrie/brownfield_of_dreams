class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friended_user, class_name: 'User'

  # validate :realism
  #
  # private
  #
  # def realism
  #   return unless user_id == friended_user_id
  # end
end
