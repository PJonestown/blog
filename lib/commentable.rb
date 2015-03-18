require 'active_support'

module Commentable
  extend ActiveSupport::Concern

  def comments
    @commentable = find_commentable
    @comments = @commentable.comments
    #@comment = current_commenter.comments.new #todo maybe cchange
    @comment = Comment.new
  end

  private

  def find_commentable
    return params[:controller].singularize.classify.constantize.find(params[:id])
  end
end
