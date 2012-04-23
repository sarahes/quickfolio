class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    redirect_to authentications_url
  end

  def destroy
    @authentication = current_user.authentication.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
end
