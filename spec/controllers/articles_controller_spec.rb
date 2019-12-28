require 'rails_helper'

describe ArticlesController, type: :controller do

  describe "#index" do
    subject {get :index}
    
    it 'deberia responder OK' do
      subject
      expect(response).to  have_http_status(:ok)
    end

    it "deberia responder un objeto JSON" do
      articles = create_list :article, 3
      subject
      pp json # => impime la variable
      articles.each_with_index do |article, index|
        expect(json_data[index]['attributes']).to eq({
          "title" => article.title,
          "content" => article.content,
          "slug" => article.slug
        })  
      end
    end
    
  end
  
  
end
