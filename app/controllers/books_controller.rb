class BooksController < ApplicationController


  before_action :find_book
  before_filter :authenticate_user!
  before_action :check_if_admin, only: [:destroy]

  def index

    @books = Book


    if (current_user.role == 'admin')
      @books = @books.all
    else
      @books = Book.where(access: current_user.role)
    end

  end

  def show
    unless @book
      render text: "Page not found", status: 404
    end
  end

  def new
    @book = Book.new
  end

  def create

    book_params = params.require(:book).permit!
    @book = Book.create(book_params)
    if @book.errors.empty?
      redirect_to book_path(@book) # /books/:id

    else
      render "new"

    end

  end


  def edit
  end


  # /note/1 PUT
  def update

    @book.update_attributes(params.require(:book).permit!)

    if @book.errors.empty?
      redirect_to book_path(@book)
    else
      render "edit"
    end


  end

  def destroy
    @book.destroy
     redirect_to action: "index"
    #render json: { success: true }
    #render books_path
  ##  ItemsMailer.item_destroyed(@item).deliver
  end


  private
  def find_book
    @book = Book.where(id: params[:id]).first
    # render_404 unless @book
  end



end