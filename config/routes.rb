Rails.application.routes.draw do
root 'forecasts#index'
get '/usrloc', to: 'forecasts#get_user_location'
get '/forecasts', to: 'forecasts#index'
get '/my_forecasts', to: 'forecasts#show'
post '/forecasts', to: 'forecasts#create'
post '/forecasts/updates', to: 'forecasts#email_update', as: 'email_update'
end
