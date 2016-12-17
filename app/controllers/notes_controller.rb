class NotesController < ApplicationController

  before_action :find_note
  before_filter :authenticate_user!
  before_action :set_book, only: [:index, :show, :create]
  before_action :check_if_admin, only: [:destroy]


  def index
   @notes = @book.notes



=begin

   respond_to do |format|
     format.html
     format.csv { send_data @notes.to_csv }
   end
=end


  end

  def import
    Note.import(params[:file])
    redirect_to book_notes_path, notice: "Note imported."
  end

  def show
=begin
    extention=@note.image.split('.')
     send_file Rails.root.join('public', 'uploads', @note.image),
               :type=>"application/#{extention[1]}", :x_sendfile=>true
=end

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

=begin
    uploaded_io = params[:note][:image]
    File.open(Rails.root.join('public','uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    @note.image = uploaded_io.original_filename
=end

    @note = @book.notes.create(note_params)




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
      redirect_to book_notes_path(@note.book_id, @note)
    else
      render "edit"
    end



  end

  def destroy
    @note.destroy
    redirect_to action: "index"
    #render json: { success: true }
    #render books_path
    ##  ItemsMailer.item_destroyed(@item).deliver
  end


  private
  def find_note
    @note = Note.where(id: params[:id]).first
   # render_404 unless @note
  end


  def set_book
    @book = Book.find(params[:book_id])
  end

end
