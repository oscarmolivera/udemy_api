require 'rails_helper'

RSpec.describe UserAuthenticator do
  describe "#perform:" do

    let (:authenticator) {described_class.new('Some-sample-code')}
    subject {authenticator.perform}
    
    context "cuando el código es incorrecto," do
      let(:error){double("Sawyer::Resourse", error: 'bad_verification_code')}
      before do
        allow_any_instance_of(Octokit::Client).to receive(:exchange_code_for_token).and_return(error)
      end
      
      it "debería mostrar un mensaje de ERROR." do
        expect{subject}.to raise_error(
          (UserAuthenticator::AuthenticationError)
        )
        expect(authenticator.user).to  be_nil
      end
    end

    context"cuando el código es CORRECTO," do
      let(:user_data) do
        {
          login: 'usuario1@login.com',
          url: 'http://mytestapp.com',
          avatar_url: 'http://mytestapp.com/avatar.gif',
          name: 'John Snow'
        }
      end
        before do
          allow_any_instance_of(Octokit::Client).to receive(
            :exchange_code_for_token).and_return('validaccesstoken')
  
          allow_any_instance_of(Octokit::Client).to receive(
            :user).and_return(user_data)
        end
  
        it 'deberá GUARDAR el usuario cuando no exista' do
          expect{ subject }.to change{ User.count }.by(1)
          expect(User.last.name).to eq('John Snow')
        end

        it 'deberá utilizar el mismo usuario si EXISTE.' do
          user = create :user, user_data
          expect{ subject }.not_to  change{ User.count }
          expect(authenticator.user).to  eq(user)
        end

        it 'deberá crear y setear el token de ACCESO.' do
          expect{ subject }.to change{ AccessToken.count }.by(1)
        expect(authenticator.access_token).to be_present
        end
        
    end
  end  
end