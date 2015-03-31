class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, :except =>[:show, :index] 

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show

    @comments = @post.comments
    @comment = @post.comments.build 

  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_admin.posts.new(post_params)

    if @post.save
      flash[:success] = 'Post was successfully created.'
      redirect_to @post
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post was successfully updated.'
      redirect_to @post
    else
      render :edit 
    end
  end

  def destroy
    @post = current_admin.posts.find(params[:id])
    if @post.admin == current_admin
      @post.destroy
      flash[:success] = 'Post was successfully destroyed.'
      redirect_to posts_url
    else
      flash[:error] = 'No soup for you!' 
      redirect_to root_path
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :admin_id)
    end

    def authenticate_admin!
      if admin_signed_in?
        return true
      else
        redirect_to root_path
        flash[:error] = "No soup for you!"
      end
    end

end
