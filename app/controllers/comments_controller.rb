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
    if @comment.save
      flash[:success] = 'Comment was successfully created.' 
      redirect_to :back 
    else
      render :new 
    end
  end

  def update

    if @comment.update(comment_params)
       flash[:success] = 'Comment was successfully updated.' 
       redirect_to post_path(@comment.post_id)
    else
      render :back
    end
  end

  def destroy
    if commenter_signed_in? && current_commenter.id == @comment.owner_id ||
        admin_signed_in?
      @comment.destroy
      flash[:success] = 'Comment was successfully destroyed.'
      redirect_to :back
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

