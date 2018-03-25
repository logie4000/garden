class Api::V1::ImagesController < Api::ApiController
  before_action :set_image, only: [:show]

  def show
    respond_to do |format|
     format.json { render :json => @image }
    end
  end

  def index
    @images = Image.all
  
    respond_to do |format|
      format.json {render :json => @images }
    end
  end

  def create
    @image = Image.new( :file => params[:file] )
    @image.imageable_id = params[:image][:object_id]
    @image.imageable_type = params[:image][:object_type]

    respond_to do |format|
      if (@image.save)
        format.json {render :json => @image}
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
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
