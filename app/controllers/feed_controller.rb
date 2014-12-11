class FeedController < ApplicationController

  # to do :scope posts des followings

  def index
   if current_user 
    get_suggest_users
    get_suggest_posts

    @posts = current_user.feed
    end 
  end


  def get_suggest_users
  	@users = current_user.get_suggest_users
  	
  	#(!@users.empty?) ? (render partial: "suggestusers") : (render text: "no suggest")
  end

  def get_suggest_posts

    @posts_suggest = current_user.get_suggest_posts

    #(!@posts_suggest.empty?) ? (render partial: "suggestposts") : (render text: "no suggest")
    
  end





end
