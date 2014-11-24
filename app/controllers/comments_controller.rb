class CommentsController < ApplicationController
  before_action :confirm_logged_in
  before_action :current_user


def create
  @comment = Comment.create(comment_params.merge(user_id: params[:user_id], project_id: params[:project_id]))
  render json: {comment: @comment.body, user: @comment.user.firstname, image: @comment.user.picurl}
end


  private
  def comment_params
    params.require(:comment).permit(:body)
  end

end


