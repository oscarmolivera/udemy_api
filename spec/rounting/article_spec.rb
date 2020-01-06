require "rails_helper"

RSpec.describe "#Routing", type: :routing do
  it "enruta el GET /articles al INDEX de ArticlesController." do
    expect(get("/articles")).to route_to("articles#index")
  end

  it "enruta GET /article/1 al SHOW de ArticlesController." do
    expect(get("/articles/1")).to route_to("articles#show", id: '1')
  end

  it "enruta POST /articles al INDEX de ArticlesController." do
    expect(post("/articles")).to route_to("articles#create")
  end
end
