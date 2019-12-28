require 'rails_helper'

describe ArticlesController, type: :controller do

  describe "#index" do
    subject {get :index}
    
    it 'deberia responder OK' do
      subject
      expect(response).to  have_http_status(:ok)
    end

    it "deberia responder un objeto JSON" do
      create_list :article, 2
      subject
      json = JSON.parse(response.body)
      pp json # => impime la variable
      json_data = json['data']
      expect(json_data.length).to eq(2)
    end
    
  end
  
  
end
