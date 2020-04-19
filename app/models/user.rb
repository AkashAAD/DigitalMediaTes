class User < ApplicationRecord
  extend Devise::Models  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  belongs_to :role
  has_many :libraries
end
