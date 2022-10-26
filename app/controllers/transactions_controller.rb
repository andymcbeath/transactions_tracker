class TransactionsController < ApplicationController
  def index
    transactions = Transactions.all
    render json: transactions.as_json
  end

  def create
    transaction = Transaction.new(
      payer: params[:payer],
      points: params[:points],
      timestamp: params[:timestamp],
    )
    transaction.save
    render json: transaction.as_json
  end

  def update
    points_left = params[:points].to_i
    points_spent = {}
    if Transaction.pluck(:points).sum > points_left
      Transaction.order(timestamp: :asc).each do |transaction|
        if transaction.points < points_left
          points_left -= transaction.points
          points_spent[transaction.payer] = (points_spent[transaction.payer] || 0) - trnsaction.points
          transaction.destroy
        else
          points_spent[transaction.payer] = (points_spent[transaction.payer] || 0) - points_left
          transaction.update(points: transaction.points - points_left)
          break
        end
      end
      result = []

      points_spent.each do |k, v|
        result << { "payer" => k, "points" => v }
      end
      render json: result.as_json
    end
  end

  def show
    transaction = Transaction.find_by(id: params[:id])
    render json: transaction.as_json
  end
end
