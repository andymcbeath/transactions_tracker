class TransactionsController < ApplicationController
  def index
    group_of_payers = Transaction.select(:payer, "SUM(points) as points").group(:payer)

    results = {}

    group_of_payers.each do |group|
      results[group.payer] = group.points
    end

    render json: results.as_json
  end

  def create
    render json: Transaction.create(transactions_params)
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

  # def create
  #   payer = find_or_create_payer(payer: params[:payer])
  #   points = params[:points].to_i

  #   #create transaction
  #   transaction = Transaction.new(points: params[:points], payer: params[:payer], timestamp: params[:timestamp])

  #   #Adjust points based on transaction IF balance doesn't go negative
  #   if (payer.points + points >= 0)
  #     payer.save!
  #     transaction.save!
  #     payer.update(points: payer.points + points)
  #     render json: transaction
  #   else
  #     render json: "Transaction will make payer balance go negative. Transaction Cancelled."
  #   end
  # end

  def spend
    points_left = params[:points].to_i
    points_spent = {}
    if Transaction.pluck(:points).sum > points_left
      Transaction.order(timestamp: :asc).each do |transaction|
        if transaction.points < points_left
          points_left -= transaction.points
          points_spent[transaction.payer] = (points_spent[transaction.payer] || 0) - transaction.points
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

  # def find_or_create_payer(payer)
  #   if Payer.find_by(payer: payer) != nil
  #     Payer.find_by(payer: payer)
  #   else
  #     Payer.new(payer: payer, points: 0, spent: 0)
  #   end
  # end

  private

  def transactions_params
    params.require(:transactions).permit(:payer, :points, :timestamp)
  end
end
