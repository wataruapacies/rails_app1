class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @list = Book.new
    @lists= Book.all
  end

  def create
    @list = Book.new(book_params)
    @list.user_id = current_user.id
    if @list.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@list.id)
    else
      @lists= Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @list = Book.new
    @book_comment = BookComment.new
  end

  def edit
    @list = Book.find(params[:id])
  end

  def update
    @list = Book.find(params[:id])
    if @list.update(book_params)
      flash[:notice_update] = "Book was successfully updated."
      redirect_to book_path(@list.id)#"/books/#{list.id}"
    else
      render :edit
    end
  end

  def destroy
    @listroy = Book.find(params[:id])
    @listroy.destroy
    flash[:notice_destroy] = "Book was successfully destroyed."
    redirect_to books_path#'/books'
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    unless Book.find(params[:id]).user.id.to_i == current_user.id
      redirect_to books_path
    end
  end
end
