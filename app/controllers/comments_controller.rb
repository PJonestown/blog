class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_commenter!, :except => [:show, :index]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end


  def edit

    #todo change the if statement
    #todo consider checking owner_type. I think admins and commenters will be
    #able to edit each others comments if they have the same id
    if commenter_signed_in? && current_commenter.id == @comment.owner_id
    elsif admin_signed_in? && current_admin.id == @comment.owner_id
    else
      redirect_to :back
      flash[:alert] = 'No soup for you'
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    find_owner(@comment)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(@comment.post_id), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(
        :body, 
        :owner_type,
        :owner_id,
        :post_id
      )
    end

    def find_owner(comment)
      if admin_signed_in?
        comment.owner_type = 'Admin'
        comment.owner_id = current_admin.id
      elsif commenter_signed_in?
        comment.owner_type = 'Commenter'
        comment.owner_id = current_commenter.id
      end
    end

end

