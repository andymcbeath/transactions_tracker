class Transaction < ApplicationRecord
  validates :payer, :points, :timestamp, presence: true
end
