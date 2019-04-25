class CommentsController < ApplicationController

  def index
    @fobitow = Fobitow.find(params[:fobitow_id])
    #@comment = @fobitow.comments.build(comment_params)
    @comment = Comment.new
    render "fobitows/show"
  end

  def create
    @fobitow = Fobitow.find(params[:fobitow_id])
    @comment = @fobitow.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'コメントを正常に投稿しました。'
      redirect_to fobitow_path(@fobitow)
    else
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      render "fobitows/show"
    end

  end

  def destroy
    @comment = Comment.find_by(params[:id])
    @comment.destroy
     redirect_to  request.referrer || root_url
  end

  private 

  def comment_params
    params.require(:comment).permit(:body)
  end
end
