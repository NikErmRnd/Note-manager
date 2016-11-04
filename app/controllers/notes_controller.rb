class NotesController < ApplicationController

  before_action :find_note
  before_filter :authenticate_user!


  def index

    @notes = Note

   @notes = @notes.all
   #@notes = Note.where(notebook: params[:notebook])
   @notes = Note.where(access: current_user.role)
    #@notes = @notes.where(notebook: 'Note1')
   # @notes = @notes.where()
    
   # @notes = @notes.where()
   # @notes = @notes.where()

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
      redirect_to book_note_path(:books, @note) # /notes/:id

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
      redirect_to book_note_path(@note)
    else
      render "edit"
    end


  end


  private
  def find_note
    @note = Note.where(id: params[:id]).first
   # render_404 unless @note
  end

  def find_notebook
    @note = Note.where(notebook: params[:notebook]).first
    # render_404 unless @note
  end

end
