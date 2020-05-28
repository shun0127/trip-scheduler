class Plan < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: { maximum: 50 }
    validates :destination, presence: true, length: { maximum: 50 }
    has_many :schedules, dependent: :destroy
    accepts_nested_attributes_for :schedules, allow_destroy: true
    
    has_many :favorites, dependent: :destroy
    has_many :favorite_users, through: :favorites, source: :user
    has_many :comments, dependent: :destroy
    has_many :comment_users, through: :comments, source: :user    
end
