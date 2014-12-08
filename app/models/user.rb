class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :username,  presence: true, uniqueness: true
  has_many :posts

  has_attached_file :picture, :styles => { :sidebar => "480x300>", :small => "300x300>", :thumb => "100x100#"  },
  				  :default_url => "/images/:style/missing.png",
                  :url  => "/assets/pictures/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/pictures/:id/:style/:basename.:extension"

  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  def create
    puts "create_user_wesh"
    User.create(params[:user])
  end

end
