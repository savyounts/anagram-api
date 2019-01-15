Rails.application.routes.draw do
  resources :words

  get 'anagrams/:letters', :to => 'words#anagrams'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
