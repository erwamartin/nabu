class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    if !Hashtag.where("name = ?", params[:post][:hashtag])
      hashtag = Hashtag.create(name: params[:post][:hashtag])
    else
      hashtag = Hashtag.where("name = ?", params[:post][:hashtag])
    end

    @post = Post.create(user_id: 1, url: params[:post][:url], hashtag_id: hashtag.first.id, content: params[:post][:content])

    if @post.save
      redirect_to posts_path, :notice => "Your post was saved!"
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path, :notice => "Your post has been deleted"
  end
end
