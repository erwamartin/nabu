class FeedController < ApplicationController

  # to do :scope posts des followings

  def index
   if current_user 
    @users = current_user.get_suggest_users
    @posts_suggest = current_user.get_suggest_posts

    @posts = current_user.feed
    puts @posts
    end 
  end

  def get_feed
    @posts = current_user.feed(params[:id_last_post])
    (!@posts.empty?) ? (render partial: "posts/posts_list") : (render text: "0")
  end


  def get_suggest_users
  	@users = current_user.get_suggest_users
  	
  	(!@users.empty?) ? (render partial: "suggestusers") : (render text: "no suggest")
  end

  def get_suggest_posts

    @posts_suggest = current_user.get_suggest_posts

    (!@posts_suggest.empty?) ? (render partial: "suggestposts") : (render text: "no suggest")
    
  end





end
