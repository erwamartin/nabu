class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :username,  presence: true, uniqueness: true
  has_many :posts
  has_many :active_relationships,  class_name:  "Relation",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relation",
                                   foreign_key: "following_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :following, dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower, dependent:   :destroy

  has_many :bookmarks
  has_many :bookmarks_posts, :through=> :bookmarks, :class_name => 'Post', :foreign_key => 'post_id', :source => :post, :dependent => :destroy

  has_many :reposts
  has_many :reposts_posts, :through=> :reposts, :class_name => 'Repost', :foreign_key => 'post_id', :source => :post, :dependent => :destroy

  has_attached_file :picture, :styles => { :sidebar => "480x300>", :small => "300x300>", :thumb => "100x100#"  },
  				  :default_url => "/assets/default/:style/default.jpg",
                  :url  => "/assets/pictures/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/pictures/:id/:style/:basename.:extension"


  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  has_attached_file :background, :styles => { :thumb => "1000x1000#"  },
                  :default_url => "/assets/default/:style/default.jpg",
                  :url  => "/assets/pictures/:id/background/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/pictures/:id/background/:style/:basename.:extension"
                  

  validates_attachment_size :background, :less_than => 5.megabytes
  validates_attachment_content_type :background, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  def create
    User.create(params[:user])
  end

  def feed
    following_ids = "SELECT following_id FROM relations WHERE  follower_id = :user_id"
    posts = Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
    
    reposts = Repost.where("user_id IN (#{following_ids})", user_id: id)
    
    feed_posts = posts + reposts
    feed_posts.sort_by(&:created_at).reverse!
  end

  def get_suggest_users
    User.where("id != ?", id).order("RAND()").limit(2)
  end

  def get_suggest_posts
    Post.where("id != ?", id).order("RAND()").limit(2)
  end

  def follow(id)
    active_relationships.create(following_id: id)
  end

  def unfollow(id)
    active_relationships.find_by(following_id: id).destroy
  end

  def self.search_users_username_like(search)
    User.where(["username LIKE ?", "%#{search}%"])
  end

end
