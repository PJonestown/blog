class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @parent_id = params.delete(:parent_id)
    @commentable = find_commentable
    #@owner = find_owner
    #@comment = Comment.new(comment_params)
    @owner = 
      if admin_signed_in?
        @owner.type = 'Admin'
        @owner.id = 1
      elsif
        commenter_signed_in?
        type = 'Commenter'
        id = @commenter.id
      end


    @comment = Comment.new( :parent_id => @parent_id,
                            :commentable_id => @commentable.id,
                            :commentable_type => @commentable.class.to_s,
                            #todo experiment deleting these
                            :owner_type => @owner.class.to_s,
                            :owner_id => @owner.id
                          )
    #@comment.parent_id = @parent_id
    #@comment.commentable_id = @commentable.id
    #@comment.commentable_type = @commentable.class.to_s
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
   # @owner = 
    #  if admin_signed_in?
     #   @owner.type = 'Admin'
      #  @owner.id = 1
      #elsif
       # commenter_signed_in?
       # type = 'Commenter'
       # id = @commenter.id
      #end
    #@comment = Comment.new(comment_params)
    #@owner = find_owner
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)# do |c|
      #c.owner_type = @owner.class.to_s
      #c.owner_id = @owner.id
    find_owner(@comment)

    #end

    respond_to do |format|
      if @comment.save
        #format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.html { redirect_to @commentable, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
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

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(
        :body, 
        :commentable_id, 
        :commentable_type, 
        :owner_type,
        :owner_id 
      )
    end

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

