class PayersController < ApplicationController
  def index
    payers = Payer.all
    render json: payers.as_json
  end
end
