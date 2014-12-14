class PostsController < ApplicationController

  # def index
  #   @posts = Post.all
  # end

  def show
    @post = Post.find(params[:id])
    begin
      @apercu = LinkThumbnailer.generate(@post.url)
      @apercu_ok = true
    rescue SocketError => e
      @apercu_ok = false
    rescue Timeout::Error
      @apercu_ok = false
    rescue LinkThumbnailer::Exceptions
      @apercu_ok = false
    rescue StandardError::ArgumentError
      @apercu_ok = false
    end
  end


  def new
    @post = Post.new
  end

  def create
    htag_id = Hashtag.get_id_hashtag_if_exist_or_not(params[:post][:hashtag])

    @post = Post.create(user_id: current_user.id, url: params[:post][:url], hashtag_id: htag_id, content: params[:post][:content])

    if @post.save
      redirect_to root_path, :notice => "Votre post a bien été envoyé"
    else
      redirect_to root_path, :alert => "Une erreur est survenue, veuillez réessayer svp"
    end
  end

  def destroy

    post = Post.find(params[:id])
    if post.user == current_user
      
      post.destroy

      redirect_to root_path, :notice => "Votre post a bien été supprimé"
    else
      redirect_to root_path, :alert => "Vous ne pouvez supprimer ce post"
    end
  end

  def add_bookmark
    bookmark = current_user.bookmarks.create(post_id: params[:id])
    (bookmark.save) ? (render text: "1") : (render text: "no")
  end

  def remove_bookmark
    bookmark = current_user.bookmarks.find_by(post_id: params[:id]).destroy
    (bookmark.destroy) ? (render text: "0") : (render text: "no")
  end

  def add_repost
    repost = current_user.reposts.create(post_id: params[:id])
    (repost.save) ? (render text: "1") : (render text: "no")
  end

  def remove_repost
    repost = current_user.reposts.find_by(post_id: params[:id]).destroy
    (repost.destroy) ? (render text: "0") : (render text: "no")
  end

 private 
    def link_thumb_exceptions
      @apercu_ok = false
    end 

  
end
