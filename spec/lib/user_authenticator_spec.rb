require 'rails_helper'

RSpec.describe UserAuthenticator do
  describe "#perform:" do
    context "cuando el codigo es incorrecto," do

      it "debería mostrar un mensaje de ERROR." do
        authenticator = described_class.new('Some-sample-code')
        expect{authenticator.perform}.to raise_error(
          (UserAuthenticator::AuthenticationError)
        )
        expect(authenticator.user).to  be_nil
      end
      
    end
  end
end