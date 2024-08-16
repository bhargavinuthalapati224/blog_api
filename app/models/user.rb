class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
  end
  
