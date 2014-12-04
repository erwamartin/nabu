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
end
