class CommentsController < ApplicationController

  before_action :require_user_logged_in, only: [:destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
    @co = Fobitow.group(:category).order('count_category desc').count(:category)

    @fobitow = Fobitow.find(params[:fobitow_id])
    #@comment = @fobitow.comments.build(comment_params)
    @comment = Comment.new
    render "fobitows/show"
  end

  def create
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
    @fobitow = Fobitow.find(params[:fobitow_id])
    @comment = @fobitow.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'コメントを正常に投稿しました。'
      redirect_to fobitow_path(@fobitow)
    else
      flash.now[:danger] = 'コメントの投稿に失敗しました。'#@comment.errors.full_messages
#      flash[:danger] = 'コメントの投稿に失敗しました。'#@comment.errors.full_messages
      render "fobitows/show"
#      redirect_to fobitow_path(@fobitow)
    end

  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
     redirect_to  request.referrer || root_url
  end
  
  private 

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
