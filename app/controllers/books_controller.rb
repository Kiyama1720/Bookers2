class BooksController < ApplicationController
  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def create
    @books = Book.includes(:user).all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = User.find(@book.user_id)
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      render "index"
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def index
    @book = Book.new
    @books = Book.includes(:user).all
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
