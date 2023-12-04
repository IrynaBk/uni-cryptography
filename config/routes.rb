Rails.application.routes.draw do
  post 'rsa/encrypt'
  post 'rsa/decrypt'
  get 'rsa/new'
  post 'rsa/benchmark'
  post 'rc5/encrypt'
  post 'rc5/decrypt'
  get 'rc5/new'
  get '/md5_hash', to: 'md5_hash#new'
  get 'digital_signature/index'
  get '/download_signature', to: 'digital_signature#download', as: :download_signature
  post '/generate_signature', to: 'digital_signature#generate_signature'
  post '/verify_signature', to: 'digital_signature#verify_signature'
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
