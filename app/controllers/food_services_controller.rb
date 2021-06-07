class FoodServicesController < ApplicationController
  before_action :set_food_service, only: %i[ show edit update destroy ]

  # GET /food_services or /food_services.json
  def index
    @food_services = FoodService.all
  end

  # GET /food_services/1 or /food_services/1.json
  def show
  end

  # GET /food_services/new
  def new
    @food_service = FoodService.new
  end

  # GET /food_services/1/edit
  def edit
  end

  # POST /food_services or /food_services.json
  def create
    @food_service = FoodService.new(food_service_params)

    respond_to do |format|
      if @food_service.save
        format.html { redirect_to @food_service, notice: "Food service was successfully created." }
        format.json { render :show, status: :created, location: @food_service }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_services/1 or /food_services/1.json
  def update
    respond_to do |format|
      if @food_service.update(food_service_params)
        format.html { redirect_to @food_service, notice: "Food service was successfully updated." }
        format.json { render :show, status: :ok, location: @food_service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_services/1 or /food_services/1.json
  def destroy
    @food_service.destroy
    respond_to do |format|
      format.html { redirect_to food_services_url, notice: "Food service was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_service
      @food_service = FoodService.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def food_service_params
      params.require(:food_service).permit(:contact_number, :status, :time_interval)
    end
end
