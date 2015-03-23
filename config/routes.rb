Rails.application.routes.draw do
  devise_for :users
	root	'bookmarks#index'
	get	'bookmarks'	=> 'bookmarks#index'
	get 'domains'		=> 'domains#index'
#	get 'tags/:tag', to: 'bookmarks#index', as: :tag
	match 'tagged', to: 'microposts#tagged', :as => 'tagged', via: 'get'
 	
	resources :bookmarks
  resources :domains

end
