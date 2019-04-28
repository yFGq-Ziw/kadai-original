class SessionsController < ApplicationController

  def new
    @user = User.all
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
  end

  def create
    @co = Fobitow.group(:category).order('count_category desc').count(:category)

    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインしました。'
      redirect_to categorys_path(@user)
    else
      flash.now[:danger] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_path
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end