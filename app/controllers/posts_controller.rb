class PostsController < ApplicationController

  def index
    @posts = Post.where(published: true)
  end

  def new
    @post = Post.new
  end

  def show
  	@post = Post.find(params[:id])
  end

  def create
  end

  def get_suggest_posts
    @posts = Post.where("user_id != ?", current_user.id).order("RAND()").limit(2)
    (!@posts.empty?) ? (render partial: "suggestposts") : (render text: "no suggest")
  end
end
