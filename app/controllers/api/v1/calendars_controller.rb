class Api::V1::CalendarsController < Api::ApiController

  def show
    @calendar = Calendar.find(params[:id])

    respond_to do |format|
      format.json { render :json => @calendar }
    end
  end

  def index
    @calendars = Calendar.all

    respond_to do |format|
      format.json { render :json => @calendars }
    end
  end

end
