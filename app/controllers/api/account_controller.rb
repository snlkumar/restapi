class Api::AccountController < ApplicationController
  def signin
    token = ApiKey.create!
    msg = { token: token.access_token }
    respond_to do |format|
      format.html { render text: token.access_token }
      format.json { render json: msg }
    end
  end
 
  def signout
    authenticate_or_request_with_http_token do |token, options|
      token = ApiKey.find_by(access_token: token)
      if token != nil
        token.destroy
      end
    end
    msg = { status: "OK" }
    respond_to do |format|
      format.html { render text: msg[:status] }
      format.json { render json: msg }
    end
  end
end