class PostsController < ApplicationController
  rescue_from LinkThumbnailer::Exceptions, with: :link_thumb_exceptions
  rescue_from StandardError::ArgumentError, with: :link_thumb_exceptions


  # def index
  #   @posts = Post.all
  # end

  def show
    @post = Post.find(params[:id])
      @apercu = LinkThumbnailer.generate(@post.url) 
      @apercu_ok = true
  end


  def new
    @post = Post.new
  end

  def create
    if Hashtag.exists?(:name => params[:post][:hashtag])
      hashtag = Hashtag.where("name = ?", params[:post][:hashtag])
      htag_id = hashtag.first.id
    else
      hashtag = Hashtag.create(name: params[:post][:hashtag])
      htag_id = hashtag.id
    end

    @post = Post.create(user_id: current_user.id, url: params[:post][:url], hashtag_id: htag_id, content: params[:post][:content])

    if @post.save
      redirect_to root_path, :notice => "Votre post a bien été envoyé"
    else
      redirect_to root_path, :alert => "Une erreur est survenue, veuillez réessayer svp"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, :notice => "Votre post a bien été supprimé"
  end

  def add_bookmark
    bookmark = current_user.bookmarks.create(post_id: params[:id])
    (bookmark.save) ? (render text: "1") : (render text: "no")
  end

  def remove_bookmark
    bookmark = current_user.bookmarks.find_by(post_id: params[:id]).destroy
    (bookmark.destroy) ? (render text: "0") : (render text: "no")
  end

 private 
    def link_thumb_exceptions
      @apercu_ok = false
    end 

  
end
