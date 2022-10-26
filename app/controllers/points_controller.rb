class PointsController < ApplicationController
  def create
    @points = Points.new (
      points: params[:points]
      points_available_integer
    )
  end
end
