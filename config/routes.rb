Rails.application.routes.draw do
  post 'rc5/encrypt'
  post 'rc5/decrypt'
  get 'rc5/new'
  get '/md5_hash', to: 'md5_hash#new'
  resources :md5_hash, only: [:new, :create] do
    post 'download', on: :collection
  end
  root "numbers#generate"
  get 'numbers/generate', to: 'numbers#generate', as: :generate_numbers
  post 'numbers/download', to: 'numbers#download', as: :download_numbers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
