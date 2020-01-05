Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  delete "/logout", to: "access_tokens#destroy"
  post "/login", to: "access_tokens#create"
  resources :articles, only: %i[index show]
end