Rails.application.routes.draw do

  root 'pages#index'

  get 'huffman', to: 'huffman#index'

  post 'huffman', to: 'huffman#index'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
