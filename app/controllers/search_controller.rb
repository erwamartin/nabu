class SearchController < ApplicationController

  def search
    search = params[:q]
    first_c = search[0]
    @searched = params[:q]
    if first_c == "@"
      search = search[1, search.length-1] 
      @users = User.search_users_username_like(search)
      if @users
        @users_size = @users.size
      end
      @users = @users.reverse_order.first(5)
    elsif first_c == "#"
      search = search[1, search.length-1] 
      hashtag = Hashtag.find_by_name(search)
      if hashtag
        @posts_size = hashtag.posts.size
      end
      @posts = hashtag && hashtag.posts.size > 0 ? hashtag.posts.reverse_order.first(3) : []
    else
      hashtag = Hashtag.find_by_name(search)
      (hashtag) ? (id_hashtag = hashtag.id) : (id_hashtag = 0)
      @posts = Post.search_posts_or_hashtags_like(search, id_hashtag)
      if @posts
        @posts_size = @posts.size
      end
      @posts = @posts.first(3)

      @users = User.search_users_username_like(search)
      @users_size = @users.size
      @users = @users.reverse_order.first(5)
    end
  end

# AJAX
  def get_users_for_search
    search = params[:q]
    first_c = search[0]
    if(first_c == "@")
      search = search[1, search.length-1]
    end

    @users = User.search_users_username_like(search, params[:id]).reverse_order.first(5)
    (!@users.empty?) ? (render partial: "users/users_list") : (render text: "0")
  end

  def get_posts_for_search
    search = params[:q]
    hashtag = Hashtag.find_by_name(search)
    (hashtag) ? (id_hashtag = hashtag.id) : (id_hashtag = 0)

    @posts = Post.search_posts_or_hashtags_like(search, id_hashtag, params[:id]).first(3)
    (!@posts.empty?) ? (render partial: "posts/posts_list") : (render text: "0")
  end

  def get_posts_with_hashtags_for_search
    search = params[:q]
    first_c = search[0]
    if(first_c == "#")
      search = search[1, search.length-1]
    end
    hashtag = Hashtag.find_by_name(search)

    @posts = hashtag && hashtag.posts.size > 0 ? hashtag.posts.where("id < ?", params[:id]).reverse_order.first(3) : [] 
    (!@posts.empty?) ? (render partial: "posts/posts_list") : (render text: "0")    
  end
# end AJAX
  
end
