Rails.application.routes.draw do
  devise_for :users
  get "/" => "home#index"
  get "users/:id/show" => "users#show"
  get "users/:id/edit" => "users#edit"
  get "users/:id/entry" => "users#entry"
  post "users/:id/update" => "users#update"
  patch "users/:id/add" => "users#add"
  get "studios" => "studios#index"
  resources :messages, only: [:create]
  resources :talk_rooms, only: [:create, :index, :show]
end
