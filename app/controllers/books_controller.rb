class BooksController < ApplicationController
  before_action :is_matching_login_user, only:[:edit, :update]
  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end

  def index
    @books = Book.all
    @book_new = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = User.find(@book.user.id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def is_matching_login_user
      @book = Book.find(params[:id])
      user = User.find(@book.user.id)
      unless @book.user.id == current_user.id
        redirect_to books_path
      end
    end
end
