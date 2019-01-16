Rails.application.routes.draw do
  root 'words#index'
  resources :words, param: :letters

  get '/anagrams/:letters(/:limit)', :to => 'words#anagrams', constraints: { limit: /[0-9]+/ }
  get '/dictionary_stats', :to => 'words#dictionary_stats'

  delete '/words', :to => 'words#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
