class Api::V1::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.json { render :json => @user, :except => [:password_hash, :password_salt, :api_key] }
    end
  end

  def index
    @users = User.all

    respond_to do |format|
      format.json { render :json => @users, :except => [:password_hash, :password_salt, :api_key] }
    end
  end
end
