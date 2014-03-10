class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)

    if @note.save
      render :json => @note
    else
      flash[:errors] = @note.errors.full_messages
    end
  end

  def destroy
    @note = Note.find(params[:id])

    @notable = @note.notable
    @note.destroy
    if @notable.class == Project
      redirect_to project_url(@notable)
    else
      redirect_to deliverable_url(@notable)
    end
  end

  def edit
  end

  def show
    @note = Note.find(params[:id])
  end


  private

  def note_params
    params.require(:note).permit(:body, :notable_id, :notable_type)
  end

  def check_logged_in_note
    note = Note.find(params[:id])
    user = note.notable.class.to_s == "Project" ?
      note.notable.user : note.notable.project.user
    check_logged_in(user)
  end
end
