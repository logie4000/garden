class Api::ApiController < ActionController::Base

  before_action :authenticate


  private
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      users_with_key = User.where("api_key = #{token}")
      return false if (users_with_key.count > 1)

      @user = users_with_key.first
    end
  end
end
