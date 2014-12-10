class Post < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :user

  has_many :bookmarks
  has_many :users, through: :bookmarks

  validates :user, presence: true
  validates :url, presence: true, format: { with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix , on: :create }

end
