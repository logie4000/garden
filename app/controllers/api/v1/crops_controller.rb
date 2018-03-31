class Api::V1::CropsController < Api::ApiController

  def show
    @crop = Crop.find(params[:id])

    respond_to do |format|
     format.json { render :json => @crop }
    end
  end

  def index
    @crops = Crop.all
  
    respond_to do |format|
      format.json {render :json => @crops }
    end

  end  
end
