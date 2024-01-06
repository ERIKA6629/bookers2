class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  
  def edit
    if user_signed_in?
      @book = Book.find(params[:id])
    else
      redirect_to new_user_session_path
    end
  end
  
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(book.id)
  end
  
  def new
    @book = Book.new
  end
 
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :new
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.delete
    redirect_to books_path
  end
  
  def index
    @book = Book.all
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user_id == current_user
  end
  
end
