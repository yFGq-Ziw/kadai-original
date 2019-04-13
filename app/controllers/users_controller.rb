class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :edit, :update, :create_image]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @fobitows = @user.fobitows.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  #User編集追加
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    #編集しようとしてるユーザーがログインユーザーとイコールかをチェック
    if current_user == @user
      if @user.update(user_params_without_password)
        flash[:success]
        #redirect_back(fallback_location: root_path)
        redirect_to @user
      else
        flash.now[:danger] = 'プロフィールは更新されませんでした'
        render :edit
        #redirect_to @user
      end
    else
      redirect_to root_url
    end    
  end    
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end

  def likes
    @user = User.find(params[:id])
    @fobitows = @user.likes.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  private
  #ストロングパラメーター
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :comment, :image, :image_cache, :remove_image)
  end

  def user_params_without_password
    params.require(:user).permit(:name, :email, :comment, :image, :image_cache, :remove_image)
  end
end