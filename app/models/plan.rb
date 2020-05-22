class Plan < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: { maximum: 50 }
    validates :destination, presence: true, length: { maximum: 50 }
    has_many :schedules, dependent: :destroy
    accepts_nested_attributes_for :schedules, allow_destroy: true
end
