class ArchitectsController < ApplicationController
  before_action :set_architect, only: %i[ show edit update destroy ]

 
  def index
    @architects = Architect.joins(:user)
                         .left_joins(user: :city)
                         .left_joins(:specializations)
                         .distinct

    if params[:query].present?
      normalized_query = I18n.transliterate(params[:query]).downcase
      @architects = @architects.where("LOWER(users.first_name) LIKE ? OR
                                      LOWER(users.last_name) LIKE ? OR
                                      LOWER(architects.description) LIKE ? OR
                                      LOWER(cities.name) LIKE ? OR
                                      LOWER(specializations.name) LIKE ?",
                                      "%#{normalized_query}%", "%#{normalized_query}%", "%#{normalized_query}%", "%#{normalized_query}%", "%#{normalized_query}%")
    end

    if params[:specialization_id].present?
      @architects = @architects.where(specializations: { id: params[:specialization_id] })
    end
  end

 
  def show
    # si architecte a un portfolio, on récupères ses medias
    @multimedias = @architect.projects.includes(:multimedias).map(&:multimedias).flatten
  end


  def new
    @architect = Architect.new
  end

  
  def edit
  end

  
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
      @architect = Architect.includes(:specializations, user: :city, projects: :multimedias).find(params.expect(:id))
    rescue ActiveRecord::RecordNotFound
      redirect_to architects_path, alert: "Architecte non trouvé."
    end

    # Only allow a list of trusted parameters through.
    def architect_params
      params.fetch(:architect, {})
    end
end
