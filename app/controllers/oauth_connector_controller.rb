class OauthConnectorController < ApplicationController
  def update
    data = request.env['omniauth.auth']
    current_user.update(token: data.credentials.token, uid: data.credentials.id)
    redirect_to dashboard_path
  end
end
