class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_commenter!, :except => [:show, :index]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @parent_id = params.delete(:parent_id)
    @commentable = find_commentable
    @comment = Comment.new( :parent_id => @parent_id,
                            :commentable_id => @commentable.id,
                            :commentable_type => @commentable.class.to_s)
  end

  def edit
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    find_owner(@comment)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: 'Comment was successfully created.' }
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
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
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
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
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
        :commentable_id, 
        :commentable_type, 
        :owner_type,
        :owner_id 
      )
    end

    #Ryan Bates black magic
    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
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

