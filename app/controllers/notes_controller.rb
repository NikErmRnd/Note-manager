class NotesController < ApplicationController

  before_action :find_note
  before_filter :authenticate_user!
  before_action :set_book, only: [:index, :show]

  def index

   @notes = Note
   if (current_user.role == 'admin')
     @notes = @notes.all
   else
   @notes = Note.where(access: current_user.role)
   end
   @notes = @notes.where(book_id: @books)


  end


  def show
    unless @note
      render text: "Page not found", status: 404
    end
  end

  def new
    @note = Note.new
  end


  # /notes POST
  def create

    note_params = params.require(:note).permit!
    @note = Note.create(note_params)
    if @note.errors.empty?
      redirect_to book_notes_path # /notes/:id

    else
      render "new"

    end

  end


  def edit
  end


  # /note/1 PUT
  def update

    @note.update_attributes(params.require(:note).permit!)

    if @note.errors.empty?
      redirect_to book_notes_path(@note)
    else
      render "edit"
    end


  end


  private
  def find_note
    @note = Note.where(id: params[:id]).first
   # render_404 unless @note
  end


  def set_book
    @books = Book.find(params[:book_id])
  end

end
