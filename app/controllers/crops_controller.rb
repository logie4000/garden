class CropsController < ApplicationController
  before_action :authorize, only: [:edit, :update]
  before_action :authorize_as_admin, only: [:destroy]
  before_action :set_crop, only: [:show, :edit, :update, :destroy, :add_new_season]

  # GET /crops
  # GET /crops.json
  def index
    @crops = Crop.all.sort_by {|crop|  [crop.get_start_datetime, crop.name]}
  end

  # GET /crops/1
  # GET /crops/1.json
  def show
  end

  # GET /crops/new
  def new
    @crop = Crop.new
  end

  # GET /crops/1/edit
  def edit
  end

  # POST /crops
  # POST /crops.json
  def create
    if params[:crop][:start_offset_weeks]
      params[:crop][:start_offset] = params[:crop][:start_offset_weeks].to_i * 7
    end

    if params[:crop][:transplant_offset_weeks]
      params[:crop][:transplant_offset] = params[:crop][:transplant_offset_weeks].to_i * 7
    end

    if params[:crop][:transplant] =~ /true/i
      params[:crop][:start_date] = TEXT_BEFORE_TRANSPLANT
    end

    @crop = Crop.new(crop_params)

    respond_to do |format|
      if @crop.save
        format.html { redirect_to @crop, notice: 'Crop was successfully created.' }
        format.json { render :show, status: :created, location: @crop }
      else
        format.html { render :new }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crops/1
  # PATCH/PUT /crops/1.json
  def update
    if params[:crop][:start_offset_weeks]
      params[:crop][:start_offset] = params[:crop][:start_offset_weeks].to_i * 7
      Rails.logger.debug "Updating start_offset with #{params.inspect}"
    end

    if params[:crop][:transplant_offset_weeks]
      params[:crop][:transplant_offset] = params[:crop][:transplant_offset_weeks].to_i * 7
    end

    if params[:crop][:transplant] =~ /true/i
      params[:crop][:start_date] = TEXT_BEFORE_TRANSPLANT
    end

    respond_to do |format|
      if @crop.update(crop_params)
        format.html { redirect_to @crop, notice: 'Crop was successfully updated.' }
        format.json { render :show, status: :ok, location: @crop }
      else
        format.html { render :edit }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crops/1
  # DELETE /crops/1.json
  def destroy
    @crop.destroy
    respond_to do |format|
      format.html { redirect_to crops_url, notice: 'Crop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def welcome
  end

  def about
  end

  def graphical
    @crops = Crop.all.sort_by {|crop|  [crop.get_start_datetime, crop.name]}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crop
      @crop = Crop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crop_params
      params.require(:crop).permit(:name, :days_to_maturity, :start_offset, :start_date, :transplant, :transplant_offset, :transplant_date, :location_id, :notes, :image, season_attributes: [:id, :year, :start_date, :transplant_date, :harvest_date, :notes] )
    end
end
