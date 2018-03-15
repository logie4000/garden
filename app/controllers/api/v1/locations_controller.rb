class Api::V1::LocationsController < ApplicationController
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.json { render :json => @location }
    end
  end

  def index
    @locations = Location.all

    respond_to do |format|
      format.json { render :json => @locations }
    end
  end
end
