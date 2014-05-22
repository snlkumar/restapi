class Api::UsersController < ApplicationController
  # http_basic_authenticate_with :name => "myfinance", :password => "credit123"
  skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :json,:xml
  # GET /users
  # GET /users.json
  def index
    puts "the current user is#{restrict_access.id}"
    @users = User.all
    respond_with @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_with @users
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        respond_with @user,:status=> "created"        
      else
        respond_with @user.errors,:status=> "failed"
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update    
      if @user.update(user_params)
        respond_with @user,:status=> "updated" 
      else
        respond_with @user.errors,:status=> "failed" 
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.destroy
      respond_with @user,:status=> "deleted" 
   else
     respond_with @user.errors,:status=> "failed" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :city)
    end
end
