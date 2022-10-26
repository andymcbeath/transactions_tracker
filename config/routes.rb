Rails.application.routes.draw do
  get "/transactions" => "transactions#index"
  post "/transactions" => "transactions#create"
  get "/transactions/:id" => "transactions#show"
  get "/payers" => "payers#index"
end
