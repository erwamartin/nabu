class Post < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :user

  validates :user, presence: true
end
