class User < ApplicationRecord
    has_many :posts

    has_many :comments
    has_many :comented_posts, through: :comments, source: :post
end
