class FeedController < ApplicationController

  def index
    get_suggest_users
    get_suggest_posts
    get_followings_array_id
    get_followers_array_id

    @posts = Post.all
  end


  def get_suggest_users
  	@users = User.where("id != ?", current_user.id).order("RAND()").limit(2)
  	
  	#(!@users.empty?) ? (render partial: "suggestusers") : (render text: "no suggest")
  end

  def get_suggest_posts
    @posts = Post.where("user_id != ?", current_user.id).order("RAND()").limit(2)
    
  end





end
