Deltafin::Application.routes.draw do
  resources :accounts
  devise_for :users
  root :to => 'high_voltage/pages#show', :id => 'index'

  match "transfer_from"  => "accounts#transfer_from"
  match "transfer"       => "accounts#transfer"
  match "get_funds"      => "accounts#get_funds"
  match "infuse"         => "accounts#infuse"

end
