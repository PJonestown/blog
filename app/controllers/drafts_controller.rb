class DraftsController < ApplicationController
  before_action :set_draft, only: [:show, :edit, :update, :destroy]
  before_action :admin, only: [
    :index, :show, :new, :edit, :update, :create, :destroy]

  def index
    @drafts = Draft.all
  end

  def show
  end

  def new
    @draft = Draft.new
  end

  def edit
  end

  def create
    @draft = current_admin.drafts.new(draft_params)
    if @draft.save
     redirect_to @draft, notice: 'Draft was successfully created.' 
    else
     render :new 
    end
  end

  def update
    if @draft.update(draft_params)
      redirect_to @draft, notice: 'Draft was successfully updated.' 
    else
      render :edit
    end
  end

  def destroy
    @draft.destroy
    redirect_to drafts_url, notice: 'Draft was successfully destroyed.'
  end

  private
    def set_draft
      @draft = Draft.find(params[:id])
    end

    def draft_params
      params.require(:draft).permit(:title, :body, :admin_id)
    end

    def admin
      redirect_to root_url unless admin_signed_in?
    end
end
