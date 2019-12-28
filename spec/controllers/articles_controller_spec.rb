require 'rails_helper'

describe ArticlesController, type: :controller do

  describe "#index" do
    subject {get :index}
    
    it 'deberia responder OK' do
      subject
      expect(response).to  have_http_status(:ok)
    end

    it "deberia responder un objeto JSON" do
      create_list :article, 3
      subject
      #pp json # => impime la variable
      Article.recent.each_with_index do |article, index|
        expect(json_data[index]['attributes']).to eq({
          "title" => article.title,
          "content" => article.content,
          "slug" => article.slug
        })  
      end
    end

    it "deberá mostrar los articulos en ORDEN Invertido" do
        old_article = create :article
        new_article = create :article
        subject
        expect(json_data.first['id']).to eq(new_article.id.to_s)  
        expect(json_data.last['id']).to eq(old_article.id.to_s)  
    end

    it "deberá poder PAGINAR resultados." do
      create_list :article, 3
      get :index, params: { page:2, per_page: 1 }
      expect(json_data.length).to  eq(1)
      expected_article = Article.recent.second.id.to_s  
      expect(json_data.first['id']).to  eq(expected_article)
    end
    
  end

  describe '#show' do
    let(:article) { create :article }
    subject { get :show, params: { id: article.id } }

    it 'deberá responder estado OK.' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'deberá responder un objeto json FORMATEADO' do
      subject
      expect(json_data['attributes']).to eq({
          "title" => article.title,
          "content" => article.content,
          "slug" => article.slug
      })
    end
  end
end
