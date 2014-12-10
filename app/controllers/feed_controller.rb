class FeedController < ApplicationController

  # to do :scope posts des followings

  def index
   if current_user 
    get_suggest_users
    get_suggest_posts
   
    following_ids = "SELECT following_id FROM relations
                     WHERE  follower_id = :user_id"
    @posts = Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: current_user.id).reverse_order
    end 
  end


  def get_suggest_users
  	@users = User.where("id != ?", current_user.id).order("RAND()").limit(2)
  	
  	#(!@users.empty?) ? (render partial: "suggestusers") : (render text: "no suggest")
  end

  def get_suggest_posts
    #Ajouter id_user != current_user.id ;)

    @posts_suggest = Post.order("RAND()").limit(2)
    
  end





end
