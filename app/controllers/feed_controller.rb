class FeedController < ApplicationController

  # to do :scope posts des followings

  def index
<<<<<<< HEAD
    if current_user
      get_suggest_users
      get_suggest_posts
      get_followings_array_id
      get_followers_array_id

      @posts = Post.all
    end
=======
    
    get_suggest_users
    get_suggest_posts
   

    @posts = Post.all
>>>>>>> 71a1988c525c21443bfeeb36454bb6709833c69d
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
