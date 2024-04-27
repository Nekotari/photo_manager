class PhotosController < ApplicationController
  def new
    @photo = current_user.photos.new
  end

  def create
    errors = []
    if params[:photo][:image].nil?
      errors << "Image file was not entered"
    end
    if params[:photo][:description].empty?
      errors << "Title was not entered"
    end
    if params[:photo][:description].length >= 30
      errors << "Title it too long(maximum 30 characters)"
    end
    @photo = current_user.photos.new(photo_params)

    if errors.any?
      flash[:error] = errors
      redirect_to new_photo_path
    elsif @photo.save
      redirect_to root_path, notice: 'Photo uploaded successfully!'
    else
      render :new, alert: 'Failed to upload photo.'
    end
  end

  def index
    @photos = current_user.photos
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :description)
  end
end
