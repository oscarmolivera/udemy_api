require 'rails_helper'
describe "#routing" do
  
  it 'redireccionar request de articulos a INDEX' do
    expect(get '/articles').to route_to('articles#index')
  end
end
