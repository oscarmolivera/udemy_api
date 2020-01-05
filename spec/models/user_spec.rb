require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validations" do
    it "deberá tener un FACTORY válido." do
      user = build :user
      expect(user).to  be_valid
    end
    
    it "deberá validar PRECENCIA de atributos." do
      user = build :user, login: nil, provider: nil
      #pp user   
      expect(user).not_to be_valid
      expect(user.errors.messages[:login]).to include("can't be blank")
      expect(user.errors.messages[:provider]).to include("can't be blank")
    end

    it "deberá tener un LOGIN único" do
      create :user
      should validate_uniqueness_of(:login)
    end

    it "deberá generar un ÚNICO token por Usuario/Vez" do
      user = create :user
      access_token = user.create_access_token
      expect(access_token.token).to eq(access_token.reload.token)
    end
    
  end
  
end
