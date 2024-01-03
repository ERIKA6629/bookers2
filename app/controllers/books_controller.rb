class BooksController < ApplicationController
  
  def edit
    
  end
  
  def new
    @book = Book.new
  end
 
  
  def create
    book = Book.new(book_params)
    book.save
    byebug
    redirect_to book_path(book)
  end
  
  def index
   
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
    
  end
  
end
