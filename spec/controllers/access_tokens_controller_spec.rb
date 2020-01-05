require 'rails_helper'

RSpec.describe AccessTokensController, type: :controller do
  describe "#create" do
    shared_examples_for "unauthorized_requests" do
      let(:error) do
        {
          "status" => "401",
          "source" => { "pointer" => "/code" },
          "title" =>  "Authentication code is invalid",
          "detail" => "You must provide valid code in order to exchange it for token."
        }
      end

      it "si no EXISTE el código, responder en 401." do
        subject
        expect(response).to  have_http_status(401)
      end

      it "deberá retornar una ESTRUCTURA Json de Error." do
        subject
        expect(json['errors']).to  include(error)
      end
    end
    context "cuando no se provee código" do
      subject { post :create } 
      it_behaves_like "unauthorized_requests"
      
    end
    context "cuando el código provisto es invalido" do
      let(:github_error){double("Sawyer::Resourse", error: 'bad_verification_code')}
      
      before do
        allow_any_instance_of(Octokit::Client).to receive(:exchange_code_for_token).and_return(github_error)
      end

      subject { post :create, params: {code: "Invalid code"} } 
      it_behaves_like "unauthorized_requests"
      
    end
    
    context "cuando el Request es VÁLIDO" do
      let(:user_data) do
        {
          login: 'usuario1@login.com',
          url: 'http://mytestapp.com',
          avatar_url: 'http://mytestapp.com/avatar.gif',
          name: 'John Snow'
        }
      end
      before do
        allow_any_instance_of(Octokit::Client).to receive(:exchange_code_for_token).and_return('validaccesstoken')

        allow_any_instance_of(Octokit::Client).to receive(:user).and_return(user_data)
      end
      
     subject { post :create, params: {code: "Valid code"} }
     
      it "deberá retornar código 201 al crearla." do
        subject
        expect(response).to  have_http_status(:created)
      end

      it "deberá retornar un objeto JSon con ESTRUCTURA." do
        expect{ subject }.to change{ User.count }.by(1)
        user = User.find_by(login: "usuario1@login.com" )
        expect(json_data['attributes']).to  eq({'token' => user.access_token.token})
      end
    end
  end
end
