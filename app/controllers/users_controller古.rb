class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :likes, :edit, :update, :create_image]
  before_action :user_find, only: [:show, :edit, :update, :followings, :followers, :likes]

  def index
    @users = User.all.page(params[:page]).per(15)
  end

  def show
    if params[:select] == 'all'
      @fobitows = Fobitow.all.order('favorites_count DESC').page(params[:page]).search(params[:search]).per(15)
    else
      @fobitow = Fobitow.new
      @fobitows = @user.fobitows.order('created_at DESC').page(params[:page]).search(params[:search]).per(15)
      counts(@user)
    end
#    end
  end
  
  def new
    @user = User.new
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
  end

  def create
    @user = User.new(user_params)
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
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
    unless current_user == @user
      redirect_to root_url
    end 
  end

  def update
    #編集しようとしてるユーザーがログインユーザーとイコールかをチェック
    if current_user == @user
      if @user.update(user_params_without_password)
        flash[:success]
        #redirect_back(fallback_location: root_path)
        redirect_to @user
      else
        flash.now[:danger] = 'プロフィールは更新されませんでした。'
        render :edit
        #redirect_to @user
      end
    else
      redirect_to root_url
    end    
  end    
  
  def followings
    @followings = @user.followings.page(params[:page]).per(15)
    @ranking_counts = Follow.ranking
    counts(@user)
  end
  
  def followers
    @followers = @user.followers.page(params[:page]).per(15)
    @ranking_counts = Follow.ranking
    counts(@user)
  end

  def likes
    @fobitows = @user.likes.order('created_at DESC').page(params[:page]).per(15)
    counts(@user)
  end

  private

  def user_find
    @user = User.find(params[:id])
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
  end

  #ストロングパラメーター
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :comment, :image, :image_cache, :remove_image)
  end

  def user_params_without_password
    params.require(:user).permit(:name, :email, :comment, :image, :image_cache, :remove_image)
  end
end
