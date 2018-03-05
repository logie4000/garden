class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authorize
    user = get_current_user
    if (user)
      session[:user_id] = user.id
    else
      session[:intended_params] = params
      flash[:notice] = "Please log in"
      redirect_to :controller => 'users', :action => 'login'
    end     
  end

  def authorize_as_admin
    user = get_current_user
    if (user)
      session[:user_id] = user.id
      unless (user.id == 5)
        flash[:notice] = "Only administrators are authorized to use that page."
        session[:intended_params] = params
        redirect_to("/welcome", status: 303)
      end
    else
      authorize
    end
  end
  
  def get_current_user
    user = User.find_by_id(session[:user_id])
    if not user
      # try to see if the request comes with HTTP simple authentication data 
      uid, password = get_simple_auth_data
      if uid and password
        user = User.authenticate(uid, password)
      end
    end

    if user 
      session[:user_id] = user.id
      return user
    else
      return nil
    end   
  end

  def get_simple_auth_data 
    auth_data = nil
    [
      'REDIRECT_REDIRECT_X_HTTP_AUTHORIZATION',
      'REDIRECT_X_HTTP_AUTHORIZATION',
      'X-HTTP_AUTHORIZATION', 
      'HTTP_AUTHORIZATION'
    ].each do |key|
      if request.env.has_key?(key)
        auth_data = request.env[key].to_s.split
        break
      end
    end

    if auth_data && auth_data[0] == 'Basic' 
      return Base64.decode64(auth_data[1]).split(':')[0..1] 
    end 
end
end
