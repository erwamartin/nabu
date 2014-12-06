class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :username,  presence: true, uniqueness: true
  has_many :posts

  def create
    User.create(params[:user])
  end

  def update
    #user = current_account.people.find(params[:id])
    #user.update!(user_params)
    #redirect_to user
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :description, :picture, :password)
    end

end
