class ArchitectsController < ApplicationController
  before_action :set_architect, only: %i[ show edit update destroy ]

  # GET /architects or /architects.json
  def index
    @architects = Architect.all
  end

  # GET /architects/1 or /architects/1.json
  def show
    @multimedias = @architect.portfolio.multimedias if @architect.portfolio
  end

  # GET /architects/new
  def new
    @architect = Architect.new
  end

  # GET /architects/1/edit
  def edit
  end

  # POST /architects or /architects.json
  def create
    @architect = Architect.new(architect_params)

    respond_to do |format|
      if @architect.save
        format.html { redirect_to @architect, notice: "Architect was successfully created." }
        format.json { render :show, status: :created, location: @architect }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @architect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /architects/1 or /architects/1.json
  def update
    respond_to do |format|
      if @architect.update(architect_params)
        format.html { redirect_to @architect, notice: "Architect was successfully updated." }
        format.json { render :show, status: :ok, location: @architect }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @architect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /architects/1 or /architects/1.json
  def destroy
    @architect.destroy!

    respond_to do |format|
      format.html { redirect_to architects_path, status: :see_other, notice: "Architect was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_architect
      @architect = Architect.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def architect_params
      params.fetch(:architect, {})
    end
end
