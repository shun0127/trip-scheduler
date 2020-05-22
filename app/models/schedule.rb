class Schedule < ApplicationRecord
    belongs_to :plan
    validates :date, presence: true
    validates :time, presence: true
    validates :destination, presence: true, length: { maximum: 50 }
end
