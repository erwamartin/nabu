class Post < ActiveRecord::Base
  belongs_to :hashtag, :user
  validates :user, presence: true
  
end
