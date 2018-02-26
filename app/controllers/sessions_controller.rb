class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    if current_user.google_auth
      redirect_to root_path
    else
      redirect_to google_oauth_redirect_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end