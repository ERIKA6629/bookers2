class BooksController < ApplicationController
  
  def edit
      @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(book.id)
  end
  
  def new
    
  end
 
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @book_index = Book.all
      render :index
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.delete
    redirect_to books_path
  end
  
  def index
    @user = current_user
    @book = Book.new
    @book_index = Book.all
  end
  
  def show
    @book_detail = Book.find(params[:id])
    @user = @book_detail.user
    @book = Book.new
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to new_user_session_path
    end
  end
 
end
