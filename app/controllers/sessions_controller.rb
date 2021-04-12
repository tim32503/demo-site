class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if User.login(user_params)
      redirect_to root_path
    else
      render :new
    end
    # 1 查有無帳號/密碼
    # 2 轉址/重登
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
