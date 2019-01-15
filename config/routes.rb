Rails.application.routes.draw do
  resources :words, param: :letters

  get '/anagrams/:letters', :to => 'words#anagrams'
  delete '/words', :to => 'words#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
