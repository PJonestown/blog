class PostsController < ApplicationController

  include Commentable
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, :except =>[:show, :index] 

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show

    #todo why isn't this already defined in module?

    @commentable = find_commentable
    @comments = @commentable.comments
    @comment = Comment.new 

  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_admin.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = current_admin.posts.find(params[:id])
    if @post.admin == current_admin
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path
      flash[:alert] = "No soup for you!"
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
        flash[:alert] = "No soup for you!"
      end
    end

end
