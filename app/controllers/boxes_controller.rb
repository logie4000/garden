class BoxesController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update]
  before_action :authorize_as_admin, only: [:destroy]
  before_action :set_box, only: [:show, :edit, :update, :destroy]

  # GET /boxes
  # GET /boxes.json
  def index
    @boxes = Box.all
  end

  # GET /boxes/1
  # GET /boxes/1.json
  def show
  end

  # GET /boxes/new
  def new
    @box = Box.new
  end

  # GET /boxes/1/edit
  def edit
  end

  # POST /boxes
  # POST /boxes.json
  def create
    @box = Box.new(box_params)

    # Create squares for this box
    if (params[:box][:box_layout])
      layout = params[:box][:box_layout]
      Rails.logger.debug "Building squares for box with layout = '#{layout}'"
      if (layout =~ /\dx\d/)
        m = layout.match(/(\d)x(\d)/)
        rows = m[1]
        cols = m[2]
        (1..rows.to_i).each do |r|
          (1..cols.to_i).each do |c|
            Rails.logger.debug "Building square for row: #{r}, col: #{c}"
            @box.squares << Square.new(:row => r, :column => c)
          end
        end

        params[:box][:rows] = rows
        params[:box][:cols] = cols
      end
    else
      Rails.logger.debug "No box layout in params: #{params}"
    end
    
    respond_to do |format|
      if @box.save
        format.html { redirect_to @box, notice: 'Box was successfully created.' }
        format.json { render :show, status: :created, location: @box }
      else
        format.html { render :new }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boxes/1
  # PATCH/PUT /boxes/1.json
  def update
    if (params[:box][:box_layout])
      layout = params[:box][:box_layout]
      if (layout =~ /\dx\d/)
        m = layout.match(/(\d)x(\d)/)
        params[:box][:rows] = m[1]
        params[:box][:cols] = m[2]
      end
    end

    respond_to do |format|
      if @box.update(box_params)
        format.html { redirect_to @box, notice: 'Box was successfully updated.' }
        format.json { render :show, status: :ok, location: @box }
      else
        format.html { render :edit }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boxes/1
  # DELETE /boxes/1.json
  def destroy
    @box.destroy
    respond_to do |format|
      format.html { redirect_to boxes_url, notice: 'Box was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_box
    @box = Box.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def box_params
    params.require(:box).permit(:label, :location_id, :box_layout, :rows, :cols)
  end
end
