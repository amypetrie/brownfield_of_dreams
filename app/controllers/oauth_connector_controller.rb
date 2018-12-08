class OauthConnectorController < ApplicationController
  def update
    data = request.env['omniauth.auth']
    user_token = data.credentials.token
    current_user.update(token: user_token)
    redirect_to dashboard_path
  end
end
