class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
  end

  def index
    @users = User.all
  end

  private
    def user_params_update
      params.require(:user).permit(:name, :email, :image, :introduction)
    end
end
