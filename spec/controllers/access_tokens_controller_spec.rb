require 'rails_helper'

RSpec.describe AccessTokensController, type: :controller do
  describe "#create" do
    context "cuando el Request es INVÁLIDO" do
      let(:error) do
        {
          "status" => "401",
          "source" => { "pointer" => "/code" },
          "title" =>  "Authentication code is invalid",
          "detail" => "You must provide valid code in order to exchange it for token."
        }
      end

      it "si no EXISTE el código, responder en 401." do
        post :create
        expect(response).to  have_http_status(401)
      end

      it "deberá retornar una ESTRUCTURA Json de Error." do
        post :create
        expect(json['errors']).to  include(error)
      end
      
    end
    
    context "cuando el Request es VÁLIDO" do
      
    end
  end
end
