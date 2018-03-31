class UsersController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :authorize, except: [:oauth, :logout, :register, :login, :create, :welcome, :authenticate]
  before_action :authorize_as_admin, only: [:destroy]

  require 'rest-client'
  
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
      format.json { render :json => @user, :except => [:password_hash, :password_salt, :api_key] }
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
    @user[:api_key] = User.generate_api_key

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

  def oauth
    session_code = params[:code].to_s
    access_token = "yaddayaddayadda"
    client_id = CLIENT_ID
    client_secret = CLIENT_SECRET

    client_id.chomp!
    client_secret.chomp!
 
    Rails.logger.debug "Posting session_code = #{session_code} to github..." 
    Rails.logger.debug "CLIENT_ID = #{CLIENT_ID}"
    Rails.logger.debug "CLIENT_SECRET = #{CLIENT_SECRET}"
  begin
    request = RestClient::Request.new(:method => :post,
                :url => 'https://github.com/login/oauth/access_token',
                :payload => {:client_id => client_id,
                    :client_secret => client_secret,
                    :code => session_code,
                    :redirect_uri => "#{OAUTH_REDIRECT_URI}",
                    :state => OAUTH_STATE}.to_json,
                :headers => {:content_type => :json, :accept => :json})
    result = request.execute
    Rails.logger.debug "Result: #{result.inspect}"
    response_json = JSON.parse(result)
    Rails.logger.debug "Result: #{response_json.inspect}"
    access_token =  JSON.parse(result)['access_token']

  rescue StandardError => e
    Rails.logger.debug "Exception caught: #{e.to_s} (e.class.name)\n"
    Rails.logger.debug "Response: #{e.response.inspect}" if (e.response)
  end

    Rails.logger.debug "Received access_token: #{access_token}"
    
    scopes = JSON.parse(result)['scope'].split(',')
    has_user_email_scope = scopes.include? 'user:email'
    
    auth_result = JSON.parse(RestClient.get('https://api.github.com/user',
                                        {:params => {:access_token => access_token}}))


    # if the user authorized it, fetch private emails
    if has_user_email_scope
      auth_result['private_emails'] =
      JSON.parse(RestClient.get('https://api.github.com/user/emails',
                              {:params => {:access_token => access_token}}))
    else
      Rails.logger.debug "User does not have email scope. Scopes: #{scopes.inspect}"
    end

    Rails.logger.debug "Auth_result: #{auth_result.inspect}"

    email = auth_result['email']
    if (email.nil?)
      email = auth_result['private_emails'][0]['email']
    end

    if (email.blank?)
      Rails.logger.debug "No email provided from scopes!"
    else
      user = User.find_by_username(email)
      if (user)
        reset_session
        session[:user_id] = user.id      
      else
        user = User.new(:username => email)
        name = auth_result['name'] || auth_result['login']
        user.first_name = name if name
        user.password = rand.to_s
        user.save!
        
        session[:user_id] = user.id
      end
    end

    respond_to do |type|
      type.html {
        if not session[:user_id]
          flash[:notice] = "Invalid username or password."
          redirect_to :action => 'login'
        else
          redirect_to :action => 'welcome'
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


