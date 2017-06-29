class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザ登録しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザ登録できませんでした。"
      render :new
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,   :password_confirmation, :fam_name, :giv_name, :fam_name_kana,   :giv_name_kana)
  end
  
end

