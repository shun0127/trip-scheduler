class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                uniqueness: { case_sensitive: false }
                
    has_secure_password
    has_many :plans
    has_many :favorites , dependent: :destroy
    has_many :favorite_plans, through: :favorites, source: :plan
    has_many :comments , dependent: :destroy
    has_many :comments_plans, through: :comments, source: :plan
    
    def add_favorite(add_plan)
        self.favorites.find_or_create_by(plan_id: add_plan.id)
    end
    
    def rm_favorite(rm_plan)
        favorite= self.favorites.find_by(plan_id: rm_plan.id)
        favorite.destroy if favorite
    end
    
    def exist_favorite?(serch_plan)
        self.favorites.exists?(plan_id: serch_plan.id)
    end
    
end

