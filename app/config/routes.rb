Rails.application.routes.draw do

  #get 'dijkstra/index'

  # get 'heapsort/index'

  root 'pages#index'

  get 'huffman', to: 'huffman#index'

  post 'huffman', to: 'huffman#index'

  get 'heapsort', to: 'heapsort#index'

  post 'heapsort', to: 'heapsort#index'

  get 'dijkstra', to: 'dijkstra#index'

  post 'dijkstra', to: 'dijkstra#index'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
