Rails.application.routes.draw do

get "/log-in" => "sessions#new"
post "/log-in" => "sessions#create"
get "/log-out" => "sessions#destroy", as: :log_out

get  "/mylist" => "items#show"
post  "/mylist" => "items#show"
get  "/new" => "items#new"
post  "/new" => "items#create"
get "/edit" => "items#edit"
post "/edit" => "items#update"
delete "/mylist" => "items#destroy"
get "/others" => "items#others"
post "/others" => "items#others"
get "/purchases" => "items#purchases"
post "/purchases" => "items#purchases"
get "/mypurchases" => "items#mypurchases"
get "/settings" => "items#settings"
post "/settings" => "users#update"
delete "/settings" => "users#destroy"

post "/mypurchases" => "purchases#create"
delete "/mypurchases" => "purchases#destroy"

resources :users

end
