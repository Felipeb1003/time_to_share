class Post < ApplicationRecord
    belongs_to :user
    belongs_to :category

    has_many :comments
    has_many :commenters, through: :comments, source: :user
    
    validates :title, :date, :location, presence: :true
    
   
    def self.ordered_list
        self.order(created_at: :asc)
    end

    def self.todays_post
        where("created_at >= ?", Time.zone.now.beginning_of_day)
    end

    
end
