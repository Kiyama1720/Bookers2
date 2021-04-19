class UsersController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @users = User.all
  end

  def edit
    if params[:id] == current_user.id.to_s
      @user = User.find(params[:id])
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end

  end

  def show
    p params
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
