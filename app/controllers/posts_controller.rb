class PostsController < ApplicationController

  before_action :set_post, only: [
    :show, :edit, :update, :destroy, :update_and_publish]
  before_action :admin, :except =>[:show, :index] 

  def index
    @posts = Post.published.all.order("created_at DESC")
  end

  def show
    redirect_to root_path if @post.draft? && !admin_signed_in?    
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
    if publishing?
      @post.draft = false
    else
      @post.draft = true
    end
    if @post.save
      flash[:success] = 'Post was successfully created.'
      redirect_to @post
    else
      render :new
    end
  end

  def update
    if publishing?
      @post.draft = false
    else
      @post.draft = true
    end

    if @post.update(post_params)
      flash[:success] = 'Post was successfully updated.'
      redirect_to @post
    else
      render :edit 
    end
  end

  def destroy
    if admin_signed_in?
      @post.destroy
      flash[:success] = 'Post was successfully destroyed.'
      redirect_to posts_url
    else
      flash[:error] = 'No soup for you!' 
      redirect_to root_path
    end
  end

  def drafts
    @posts = Post.drafts.all.order("created_at DESC")
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :admin_id, :draft)
    end

    def admin
      redirect_to root_path unless admin_signed_in?
    end

    def publishing?
      params[:commit] == "Publish and save"
    end
end
