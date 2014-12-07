class PostsController < ApplicationController

  # def index
  #   @posts = Post.all
  # end

  def show
    @post = Post.find(params[:id])
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
end
