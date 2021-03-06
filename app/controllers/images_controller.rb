class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def index
    @images = Image.all
  end

  def show
  end

  def new
    @image = Image.new
  end

  def edit
  end

  def create
    @image = Image.new( :file => params[:file] )
    @image.imageable_id = params[:image][:object_id]
    @image.imageable_type = params[:image][:object_type]

    @image.save!
    Rails.logger.debug "Created a new image with attributes: #{@image.inspect}"
    render json: @image
  end

  def update
    respond_to do |format|
      if (@image.update(image_params))
        format.html { redirect_to @image, notice: "Image was successfully updated." }
        format.json { render :show, :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
  def set_image
    @image = Image.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:imagable_id, :imageable_type, :file)
  end 
end
