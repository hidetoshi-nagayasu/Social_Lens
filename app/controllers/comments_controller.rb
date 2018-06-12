class CommentsController < ApplicationController

  def create
    Comment.create(text: comment_params[:text], post_id: comment_params[:post_id], user_id: current_user.id)
    redirect_back fallback_location: root_path
  end

  def edit
  end

  def destroy
    now = Time.current
    Comment.find(params[:id]).update(is_deleted: 1, deleted_at: now)
    redirect_back fallback_location: root_path
  end

  private
  def comment_params
    params.permit(:text, :post_id)
  end

end