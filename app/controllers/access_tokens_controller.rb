class AccessTokensController < ApplicationController
  
  
 def create
    authericator = UserAuthenticator.new(params[:code])
    authericator.perform

    render json: serializer.new(authericator.access_token), status: :created
  end

  def serializer
    AccessTokenSerializer
  end
end
