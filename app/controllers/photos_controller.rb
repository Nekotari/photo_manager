require 'net/http'
require 'uri'
require 'json'

class PhotosController < ApplicationController
  def new
    @photo = current_user.photos.new
  end

  def show
    @photo = Photo.find(params[:id])
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

  def tweet
    unless session[:access_token].present?
      flash[:error] = "Access token not found. Please link with Twitter."
      redirect_to root_path and return
    end

    @photo = Photo.find(params[:id])

    tweet_data = {
      text: @photo.description,
      url: photo_url(@photo)
    }
    tweet_api_uri = URI("http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/api/tweets")
    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{session[:access_token]}"
    }
    http = Net::HTTP.new(tweet_api_uri.host, tweet_api_uri.port)
    request = Net::HTTP::Post.new(tweet_api_uri.path, headers)
    request.body = tweet_data.to_json

    response = http.request(request)

    if response.code == "201"
      flash[:success] = "Tweet posted successfully!"
    else
      flash[:error] = "Failed to post tweet. Error code: #{response.code}"
    end

    redirect_to photos_path
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :description)
  end
end
