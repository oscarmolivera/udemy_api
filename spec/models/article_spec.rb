require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "#Validaciones:" do
    
    it "es posible crear un articulo con FACTORYBOTslug." do
      expect(build :article).to be_valid  
    end

    it "es inválido un articulo con TITULO vacío." do
      article = build :article, title: ''
      expect(article).not_to  be_valid
      expect(article.errors.messages[:title]).to include("can't be blank")  
    end

    it "es inválido un articulo con CONTENIDO vacío." do
      article = build :article, content: ''
      expect(article).not_to  be_valid
      expect(article.errors.messages[:content]).to include("can't be blank")  
    end

    it "es inválido un articulo con SLUG vacío." do
      article = build :article, slug: ''
      expect(article).not_to  be_valid
      expect(article.errors.messages[:slug]).to include("can't be blank")  
    end

    it "es invalido dos articulos con el mismo SLUG." do
      should validate_uniqueness_of(:slug)
    end    
  end
  
  describe ".recent" do

    it "retorna como first el ULTIMO archivo creado." do
      older_article = create :article
      newer_article = create :article
      expect(described_class.recent).to  eq([newer_article, older_article])
      older_article.update_column :created_at, Time.now
      expect(described_class.recent).to  eq([older_article, newer_article])
    end

  end
end
