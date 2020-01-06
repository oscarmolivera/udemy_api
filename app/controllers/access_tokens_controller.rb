class AccessTokensController < ApplicationController
 skip_before_action :authorize!, only: :create 
  
 def create
    authericator = UserAuthenticator.new(params[:code])
    authericator.perform

    render json: serializer.new(authericator.access_token), status: :created
  end

  def destroy
    current_user.access_token.destroy
  end

  def serializer
    AccessTokenSerializer
  end
end
