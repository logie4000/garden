class SeasonsController < ApplicationController
  before_action :authorize, only: [:edit, :update, :destroy]
  before_action :set_season, only: [:show, :edit, :update, :destroy]

  # GET /seasons
  # GET /seasons.json
  def index
    @seasons = Season.all
  end

  # GET /seasons/1
  # GET /seasons/1.json
  def show
  end

  # GET /seasons/new
  def new
    year = Date.today.year

    if (params[:crop_id])
      @crop = Crop.find(params[:crop_id])
      if (@crop)
        @season = Season.where("crop_id = #{params[:crop_id]} AND year = #{year.to_s}").first
      end
    end

    if (@season)
      respond_to do |format|
        format.html { render :edit }
      end
    else
      @season = Season.new
      @season.crop_id = params[:crop_id] if @crop
      @season.year = year.to_s
    end
  end

  # GET /seasons/1/edit
  def edit
  end

  # POST /seasons
  # POST /seasons.json
  def create
    unless (params[:year])
      params[:year] = Date.today.year.to_s
    end

    @season = Season.new(season_params)
    @season.squares = Array.new()

    if (params[:season][:square_id])
      params[:season][:square_id].each do |square_id|
        next if (square_id.blank?)

        square = Square.find(square_id)
        @season.squares << square
      end
    end

    respond_to do |format|
      if @season.save
        format.html { redirect_to @season.crop, notice: 'Season was successfully created.' }
        format.json { render :show, status: :created, location: @season }
      else
        format.html { render :new }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seasons/1
  # PATCH/PUT /seasons/1.json
  def update
    unless (params[:year])
      params[:year] = Date.today.year.to_s
    end

    if (params[:season][:square_id])
      @season.squares.clear

      params[:season][:square_id].each do |square_id|
        next if (square_id.blank?)
      
        square = Square.find(square_id)
        @season.squares << square
      end
    end

    respond_to do |format|
      if @season.update(season_params)
        format.html { redirect_to @season.crop, notice: 'Season was successfully updated.' }
        format.json { render :show, status: :ok, location: @season }
      else
        format.html { render :edit }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seasons/1
  # DELETE /seasons/1.json
  def destroy
    @season.destroy
    respond_to do |format|
      format.html { redirect_to crops_url, notice: 'Season was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def graphical
    @seasons = Season.all.sort_by {|season| [season.start_date, season.crop.name]}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_season
      @season = Season.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def season_params
      params.require(:season).permit(:year, :start_date, :transplant_date, :harvest_date, :crop_id)
    end
end
