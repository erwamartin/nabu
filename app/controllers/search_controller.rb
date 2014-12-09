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
      @posts = Post.where(["content LIKE ?", "%#{search}%"])
      search = search[1, search.length-1] 
      @posts = hashtag && hashtag.posts.length > 0 ? hashtag.posts : []
      @users = User.where(["username LIKE ?", "%#{search}"])
    end
  end
  
end
