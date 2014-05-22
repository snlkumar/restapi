include ActionController::HttpAuthentication::Token::ControllerMethods
include ActionController::MimeResponds
include ActionController::ImplicitRender
class ApplicationController < ActionController::API
  before_filter :restrict_access 
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  private
  def restrict_access
    unless restrict_access_by_params || restrict_access_by_header
      render json: {message: 'Invalid API Token'}, status: 401
    return
    end

    @current_user = @api_key.user if @api_key
  end

  def restrict_access_by_header
    return true if @api_key
    authenticate_with_http_token do |token|
      @api_key = Apikey.find_by_token(token)
    end
  end

  def restrict_access_by_params
    return true if @api_key
    @api_key = Apikey.find_by_token(params[:token])
  end

end
