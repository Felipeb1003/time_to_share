class User < ApplicationRecord
    has_many :posts

    has_many :comments
    has_many :comented_posts, through: :comments, source: :post

    has_secure_password
    validates :email, :username, presence: :true, uniqueness: true
    
    def self.create_from_omniauth(auth)
        User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |user|
            user.username = auth['info']['name']
            user.email = auth['info']['email']
            user.password = SecureRandom.hex(20)
        end
    end


end
