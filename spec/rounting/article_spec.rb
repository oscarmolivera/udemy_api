require "rails_helper"

RSpec.describe "#Routing", type: :routing do
  it "enruta /articles al INDEX de ArticlesController." do
    expect(get("/articles")).to route_to("articles#index")
  end

  it "enruta /article al SHOW de ArticlesController." do
    expect(get("/articles/1")).to route_to("articles#show", id: '1')
  end
end
