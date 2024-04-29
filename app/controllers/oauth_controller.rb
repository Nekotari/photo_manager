require 'net/http'
require 'json'

class OauthController < ApplicationController
  def callback
    if params[:code].present?
      token_params = {
        code: params[:code],
        client_id: Rails.application.credentials.client_id,
        client_secret: Rails.application.credentials.client_secret,
        redirect_uri: "http://localhost:3000/oauth/callback",
        grant_type: "authorization_code"
      }
      token_uri = URI("http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/token")
      token_response = Net::HTTP.post_form(token_uri, token_params)

      if token_response.is_a?(Net::HTTPSuccess)
        token_data = JSON.parse(token_response.body)
        session[:access_token] = token_data["access_token"]

        redirect_to root_path
      else
        flash[:error] = "Failed to obtain access token."
        redirect_to root_path
      end
    else
      flash[:error] = "Authorization code not found."
      redirect_to root_path
    end
  end
end