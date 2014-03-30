class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    check_logged_in(params[:id])
    render :show
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :email)
    end
end
