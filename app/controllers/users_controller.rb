class UsersController < ApplicationController
  
  def new
    
  end
  
  def edit
    if user_signed_in?
      @user = User.find(params[:id])
    else
      redirect_to new_user_session_path
    end
  end
  
  def index
    @user_index = User.all
    @user = current_user
    @book = Book.new
  end
  
  def show
    
    @user = User.find(params[:id])
    @book = Book.new
    @book_index = Book.all
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :image, :introduction)
    end
    
    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to new_user_session_path
      end
    end
end
