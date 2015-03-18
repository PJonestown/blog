class PostsController < ApplicationController
  #include Blag::Commentable

  include Commentable
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, :except =>[:show, :index] 

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order("created_at DESC")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    #todo why isn't this already defined in module?

    @commentable = find_commentable
    @comments = @commentable.comments
    @comment = Comment.new 
    
    #@comment = @post.comments.build(params[:comment])
    #@comment.commentable_type = 'Post'
    #@comment.commenter = current_commenter
    #@comments = @post.comments

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    #@post = Post.new(post_params)
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

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
