class FeedController < ApplicationController

  def index

    get_suggest_users
    get_suggest_posts
   

    @posts = Post.all
  end


  def get_suggest_users
  	@users = User.where("id != ?", current_user.id).order("RAND()").limit(2)
  	
  	#(!@users.empty?) ? (render partial: "suggestusers") : (render text: "no suggest")
  end

  def get_suggest_posts
    @posts_suggest = Post.order("RAND()").limit(2)
    
  end





end
