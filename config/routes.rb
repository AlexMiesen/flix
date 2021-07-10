Rails.application.routes.draw do
  resources :genres
	get 'signin' => 'sessions#new'
	
	resource :session
	
	get 'signup' => 'users#new'
	
  resources :users
	
  root "movies#index"

	get "movies/filter/:scope" => "movies#index", as: :filtered_movies

	# get "movies/filter/hits" => "movies#index", scope: 'hits'
	# get "movies/filter/flops" => "movies#index", scope: 'flops'
		
  resources :movies do
		resources :reviews
		resources :favourites
	end
end
