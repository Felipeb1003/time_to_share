class Post < ApplicationRecord
    belongs_to :user
    belongs_to :category

    has_many :comments
    has_many :commenters, through: :comments, source: :user

end
