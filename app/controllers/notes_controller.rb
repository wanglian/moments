class NotesController < ApplicationController
  include ActionView::RecordIdentifier

  allow_unauthenticated_access only: %i[ index ]

  before_action :set_note, only: %i[ show edit update destroy ]

  # GET /notes or /notes.json
  def index
    base_query = Note.where(user: Current.user || User.first)
    @page = (params[:page] || 1).to_i
    @per_page = 10

    @notes = if params[:pinned].present?
      base_query.where.not(pinned_at: nil).order(pinned_at: :desc)
    else
      base_query.order(id: :desc)
    end

    @notes = @notes.limit(@per_page).offset((@page - 1) * @per_page)
    @has_more = @notes.count == @per_page
  end

  # GET /notes/1 or /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = Note.new(note_params)
    @note.user = Current.user

    respond_to do |format|
      if @note.save
        format.html { redirect_to notes_path, notice: "Moment was successfully created." }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to notes_path(anchor: dom_id(@note)), notice: "Moment was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy!

    respond_to do |format|
      format.html { redirect_to notes_path, status: :see_other, notice: "Moment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_pin
    @note = Note.find(params[:id])
    @note.update(pinned_at: @note.pinned? ? nil : Time.current)

    respond_to do |format|
      format.html { redirect_to notes_path(anchor: dom_id(@note)), notice: "Note #{@note.pinned? ? 'pinned' : 'unpinned'} successfully." }
      format.json { render :show, status: :ok, location: @note }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.expect(note: [ :content ])
    end
end
