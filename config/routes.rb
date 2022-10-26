Rails.application.routes.draw do
  get "/transactions" => "transactions#index"
  post "/transactions" => "transactions#create"
  post "/transactions/spend" => "transactions#create"
  get "/transactions/:id" => "transactions#show"
  get "/payers" => "payers#index"
end
