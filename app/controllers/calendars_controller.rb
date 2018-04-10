require 'weather.rb'

class CalendarsController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update]
  before_action :authorize_as_admin, only: [:destroy]
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]
  before_action :get_weather_data, only: [:show]

  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = Calendar.all
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(calendar_params)

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:name, :last_frost, :city, :state)
    end

    def get_weather_data
      set_calendar
      @weather_data = Array.new()

      if (@calendar.city && @calendar.state)
        city = @calendar.city
        state = @calendar.state
        yesterday = Date.yesterday
        dt_start = Date.parse("2018-03-01")

        # Don't grab today's data, as it may be incomplete
        (dt_start..yesterday).each do |d|
          day = d.to_s
          data = WeatherDatum.where(:date => day, :city => city, :state => state).take

          unless (data)
            json = Weather.get_date_summary(day, city, state)

            if (json)
              data = WeatherDatum.new(:raw => json.to_json, :date => day, :city => city, :state => state)
              data.save
            end
          end
        end

        @weather_data = WeatherDatum.where(:city => city, :state => state).all
      end
    end
end
