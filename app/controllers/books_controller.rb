class BooksController < ApplicationController


  before_action :find_book
  before_filter :authenticate_user!

  def index

    @books = Book

    #@books = @books.all
    #@books = Book.where(notebook: params[:notebook])
    @books = Book.all#.where(access: 'admin')
    # @books = @books.where()
    # @books = @books.where()
    # @books = @books.where()

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


  private
  def find_book
    @book = Book.where(id: params[:id]).first
    # render_404 unless @book
  end



end