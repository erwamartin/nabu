class SearchController < ApplicationController

  def search
    search = params[:q]
    first_c = search[0]
    if first_c == "@"
      search = search[1, search.length-1] 
      @users = User.where(["username LIKE ?", "%#{search}"])
    elsif first_c == "#"
      search = search[1, search.length-1] 
      hashtag = Hashtag.find_by_name(search)
      @posts = hashtag && hashtag.posts.length > 0 ? hashtag.posts : []
    else
      search_without_prefixe = search[1, search.length-1] 
      hashtag = Hashtag.find_by_name(search_without_prefixe)
      hashtag ? (id_hashtag = hashtag.id) : (id_hashtag = 0)
      @posts = Post.where(["content LIKE ? OR hashtag_id = ?", "%#{search}%", id_hashtag])
      #@hashtags = hashtag && hashtag.posts.length > 0 ? hashtag.posts : []
      @users = User.where(["username LIKE ?", "%#{search_without_prefixe}"])
    end
  end
  
end
