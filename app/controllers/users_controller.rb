class UsersController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :authorize, except: [:register, :login, :create, :welcome, :authenticate]
  before_action :authorize_as_admin, only: [:destroy]

  def welcome
    render :layout => false
  end

  def index
    @users = User.order('username')
  end

  def show
    respond_to do |format|
      format.html
      format.xml { render :xml => @user }
      format.json { render :json => @user }
    end
  end

  def register
    @user = User.new
  end

  def change_password

  end

  def update_password
    if (session[:user_id])
      @user = User.find(session[:user_id])
      @user.password = params[:user][:password]
    
      respond_to do |format|
        if @user.save
          flash[:notice] = 'Password was successfully updated'
          format.html { redirect_to @user }
        else
          render :action => 'change_password'
        end
      end
    else
      flash[:notice] = "You must be logged in for that function"
      redirect_to :action => 'login'
    end
  end

  def create
    @user = User.new(user_params)
    #@user.password = params[:user][:password]

    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'register'
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to( :action => 'show', :id => @user) }
        format.xml  { render :xml => @user }
        format.json { render :json => @user }
      else
        render :action => 'edit'
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

  def login
    if (session[:user_id])
      @user = User.find(session[:user_id])
      redirect_to @user
    end
  end

  def authenticate
    uid = params[:user][:uid]
    password = params[:user][:password]
    user = User.authenticate(uid, password)
    if user then 
      reset_session
      session[:user_id] = user.id
    end
    
    respond_to do |type|
      type.html {
        if not session[:user_id]
          flash[:notice] = "Invalid username or password."
          redirect_to :action => 'login'
        else
          default_params = ActionController::Parameters.new( :action => 'show', :id => session[:user_id] )
          intended_params = session[:intended_params] || default_params
          Rails.logger.debug "Session params: #{session[:intended_params].inspect}"
          session[:intended_params] = nil

          Rails.logger.debug "Redirecting login to intended params: #{intended_params.inspect}"
          redirect_to url_for(intended_params.permit!)
        end
      }
      type.xml {
        if (user)
          render :xml => user
        else
          head 401 # Return not authorized
        end
      }
      type.json {
        if (user)
          render :json => user
        else
          head 401  # Return not authorized
        end
      }
    end
  end

  
  def logout
    session[:user_id] = nil
    respond_to do |type|
      type.html {
        redirect_to :action => 'welcome'
      }
      type.xml {
        render :layout => false
      }
    end
  end
  
  private
  def set_user
    if (params[:id])
      @user = User.find(params[:id])
    end
    
    if (session[:user_id])
      @current_user = User.find(session[:user_id])
    end
  end
  
  def user_params
    params.required(:user).permit(:username, :first_name, :last_name, :password, :password_confirmation)
  end
end


