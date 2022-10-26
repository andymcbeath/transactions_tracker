Rails.application.routes.draw do
  get "/transactions" => "transactions#index"
end
