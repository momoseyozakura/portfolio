Rails.application.routes.draw do
  devise_for :users
  get "/" => "home#index"
  get "users/:id/show" => "users#show"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
end
