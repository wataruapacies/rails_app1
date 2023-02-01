class BookCommentsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    k = @comment
    if @comment.save
      redirect_to book_path(@book)
    else
      @error_comment = k
      @list = Book.new
      @book_comment = BookComment.new
      render "books/show"
    end
  end

  def destroy
    #@book = Book.find(params[:book_id])
    BookComment.find(params[:id]).destroy
    flash[:notice_comment_destroy] = "Comment was successfully destroyed."
    redirect_to  book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def is_matching_login_user
    unless BookComment.find(params[:id]).user.id.to_i == current_user.id
      redirect_to books_path
    end
  end
end
