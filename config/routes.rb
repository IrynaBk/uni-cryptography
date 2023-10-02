Rails.application.routes.draw do
  root "numbers#generate"
  get 'numbers/generate', to: 'numbers#generate', as: :generate_numbers
  get 'numbers/download', to: 'numbers#download', as: :download_numbers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
