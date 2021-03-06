class Tutorial < ApplicationRecord
  has_many :videos, ->  { order(position: :ASC) }
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.public_tutorials
    Tutorial.where(classroom: false)
  end

  def public_tutorial
    true if self.classroom == false
  end

end
