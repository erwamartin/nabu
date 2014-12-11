class SearchController < ApplicationController

  def search
    search = params[:q]
    first_c = search[0]
    if first_c == "@"
      search = search[1, search.length-1] 
      @users = User.search_users_username_like(search)
    elsif first_c == "#"
      search = search[1, search.length-1] 
      hashtag = Hashtag.find_by_name(search)
      @posts = hashtag && hashtag.posts.size > 0 ? hashtag.posts.reverse_order : []
    else
      hashtag = Hashtag.find_by_name(search)
      (hashtag) ? (id_hashtag = hashtag.id) : (id_hashtag = 0)
      @posts = Post.search_posts_or_hashtags_like(search, id_hashtag)
      @users = User.search_users_username_like(search)
    end
  end
  
end
