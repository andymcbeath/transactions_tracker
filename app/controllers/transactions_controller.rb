class TransactionsController < ApplicationController
  def createspend
    points_to_spend = params[:points].to_i
    spent_points = {}
    if Transaction.pluck(:points).sum > points_to_spend
      Transaction.order(timestamp: :asc).each do |transaction|
        if transaction.points < points_to_spend
          points_to_spend -= transaction.points
          spent_points[transaction.payer] = (spent_points[transaction.payer] || 0) - transaction.points
          transaction.destroy
        else
          spent_points[transaction.payer] = (spent_points[transaction.payer] || 0) - points_to_spend
          transaction.update(points: transaction.points - points_to_spend)
          break
        end
      end

      result = []

      spent_points.each do |k, v|
        result << { "payer" => k, "points" => v }
      end
      render json: result.as_json
    end
  end
end
