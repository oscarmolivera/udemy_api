class AccessTokensController < ApplicationController
  
  
 def create
    authericator = UserAuthenticator.new(params[:code])
    authericator.perform    
  end
end
