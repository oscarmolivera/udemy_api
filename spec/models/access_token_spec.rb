require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  let(:user) {create :user}
  describe "#validations" do
    it 'deberá tener un FACTORY válido.' do 
      expect(user.build_access_token).to be_valid
    end

    xit "deberá tener un token ÚNICO." do
    end 
  end

  describe "#new" do
    it "deberá tener un token presente después de inicializar" do
      expect(AccessToken.new.token).to be_present
    end

    it "deberá generar un token ÚNICO." do
      expect{ user.create_access_token }.to change{ AccessToken.count }.by(1)
      expect(user.build_access_token).to be_valid
    end
  end
end
